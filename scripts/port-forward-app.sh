#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
APP_NAME="${APP_NAME:-guacamole}"
NAMESPACE="guacamole"

case "${APP_NAME}" in
  guacamole)
    LOCAL_PORT="${LOCAL_PORT:-8281}"
    ;;
  *)
    echo "Valeur APP_NAME invalide: ${APP_NAME}"
    echo "Valeurs supportees: guacamole"
    exit 1
    ;;
esac

echo "L'application '${APP_NAME}' est accessible sur http://localhost:${LOCAL_PORT}"
kubectl --context "${KUBE_CONTEXT}" port-forward "svc/${APP_NAME}" -n "${NAMESPACE}" "${LOCAL_PORT}:80"
