#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
APP_ENV="${APP_ENV:-prod}"
APP_NAME="${APP_NAME:-demo-app}"

case "${APP_ENV}" in
  prod)
    NAMESPACE="demo-prod"
    ;;
  *)
    echo "Valeur APP_ENV invalide: ${APP_ENV}"
    echo "Valeurs supportees: prod"
    exit 1
    ;;
esac

case "${APP_NAME}" in
  demo-app)
    case "${APP_ENV}" in
      prod) LOCAL_PORT="${LOCAL_PORT:-8083}" ;;
    esac
    ;;
  hello-app)
    case "${APP_ENV}" in
      prod) LOCAL_PORT="${LOCAL_PORT:-8183}" ;;
    esac
    ;;
  *)
    echo "Valeur APP_NAME invalide: ${APP_NAME}"
    echo "Valeurs supportees: demo-app, hello-app"
    exit 1
    ;;
esac

echo "L'application '${APP_NAME}' sur '${APP_ENV}' est accessible sur http://localhost:${LOCAL_PORT}"
kubectl --context "${KUBE_CONTEXT}" port-forward "svc/${APP_NAME}" -n "${NAMESPACE}" "${LOCAL_PORT}:80"
