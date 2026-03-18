#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
ARGOCD_NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
ARGOCD_VERSION="${ARGOCD_VERSION:-v3.3.4}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
INSTALL_URL="https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml"

if ! kubectl config get-contexts "${KUBE_CONTEXT}" >/dev/null 2>&1; then
  echo "Contexte Kubernetes introuvable: ${KUBE_CONTEXT}"
  echo "Lance d'abord: make cluster-up"
  exit 1
fi

echo "Installation d'Argo CD ${ARGOCD_VERSION} dans le namespace ${ARGOCD_NAMESPACE}..."
kubectl --context "${KUBE_CONTEXT}" create namespace "${ARGOCD_NAMESPACE}" --dry-run=client -o yaml | kubectl --context "${KUBE_CONTEXT}" apply -f -
kubectl --context "${KUBE_CONTEXT}" apply -n "${ARGOCD_NAMESPACE}" --server-side --force-conflicts -f "${INSTALL_URL}"

echo "Attente de la disponibilite des pods Argo CD..."
kubectl --context "${KUBE_CONTEXT}" wait --for=condition=Ready pod --all -n "${ARGOCD_NAMESPACE}" --timeout=300s

echo "Argo CD est installe."
