#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
APP_ENV="${APP_ENV:-dev}"

case "${APP_ENV}" in
  dev)
    NAMESPACE="demo"
    LOCAL_PORT="${LOCAL_PORT:-8081}"
    ;;
  staging)
    NAMESPACE="demo-staging"
    LOCAL_PORT="${LOCAL_PORT:-8082}"
    ;;
  prod)
    NAMESPACE="demo-prod"
    LOCAL_PORT="${LOCAL_PORT:-8083}"
    ;;
  *)
    echo "Valeur APP_ENV invalide: ${APP_ENV}"
    echo "Valeurs supportees: dev, staging, prod"
    exit 1
    ;;
esac

echo "La demo '${APP_ENV}' est accessible sur http://localhost:${LOCAL_PORT}"
kubectl --context "${KUBE_CONTEXT}" port-forward svc/demo-app -n "${NAMESPACE}" "${LOCAL_PORT}:80"
