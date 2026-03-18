#!/usr/bin/env bash
set -euo pipefail

ARGOCD_NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
REPO_BRANCH="${REPO_BRANCH:-main}"
CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
APP_ENV="${APP_ENV:-dev}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Ce dossier n'est pas un depot git."
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Le depot contient des modifications non committees."
  echo "Commit puis push les fichiers avant le bootstrap GitOps."
  exit 1
fi

git fetch origin "${REPO_BRANCH}" --quiet

read -r behind ahead < <(git rev-list --left-right --count "origin/${REPO_BRANCH}...HEAD")
if [[ "${behind}" != "0" || "${ahead}" != "0" ]]; then
  echo "Le depot local n'est pas synchronise avec origin/${REPO_BRANCH}."
  echo "Pousse d'abord tes changements sur GitHub pour que Argo CD puisse lire les manifests."
  exit 1
fi

echo "Application du projet Argo CD..."
kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" -f argocd/projects/demo-project.yaml

case "${APP_ENV}" in
  dev)
    echo "Application GitOps de l'environnement dev..."
    kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" -f argocd/applications/*-dev.yaml
    ;;
  staging)
    echo "Application GitOps de l'environnement staging..."
    kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" -f argocd/applications/*-staging.yaml
    ;;
  prod)
    echo "Application GitOps de l'environnement prod..."
    kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" -f argocd/applications/*-prod.yaml
    ;;
  all)
    echo "Application GitOps de tous les environnements..."
    kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" -f argocd/applications
    ;;
  *)
    echo "Valeur APP_ENV invalide: ${APP_ENV}"
    echo "Valeurs supportees: dev, staging, prod, all"
    exit 1
    ;;
esac

echo "Bootstrap GitOps termine."
kubectl --context "${KUBE_CONTEXT}" get applications.argoproj.io -n "${ARGOCD_NAMESPACE}"
