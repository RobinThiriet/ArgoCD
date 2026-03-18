#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
APP_ENV="${APP_ENV:-dev}"
APP_NAME="${APP_NAME:-guacamole}"

case "${APP_ENV}" in
  dev)
    NAMESPACE="guacamole"
    ;;
  staging)
    NAMESPACE="guacamole-staging"
    ;;
  prod)
    NAMESPACE="guacamole-prod"
    ;;
  *)
    echo "Valeur APP_ENV invalide: ${APP_ENV}"
    echo "Valeurs supportees: dev, staging, prod"
    exit 1
    ;;
esac

case "${APP_NAME}" in
  guacamole)
    case "${APP_ENV}" in
      dev) LOCAL_PORT="${LOCAL_PORT:-8281}" ;;
      staging) LOCAL_PORT="${LOCAL_PORT:-8282}" ;;
      prod) LOCAL_PORT="${LOCAL_PORT:-8283}" ;;
    esac
    ;;
  *)
    echo "Valeur APP_NAME invalide: ${APP_NAME}"
    echo "Valeurs supportees: guacamole"
    exit 1
    ;;
esac

echo "L'application '${APP_NAME}' sur '${APP_ENV}' est accessible sur http://localhost:${LOCAL_PORT}"
kubectl --context "${KUBE_CONTEXT}" port-forward "svc/${APP_NAME}" -n "${NAMESPACE}" "${LOCAL_PORT}:80"
