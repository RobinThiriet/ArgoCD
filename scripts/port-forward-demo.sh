#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"

echo "La demo est accessible sur http://localhost:8081"
kubectl --context "${KUBE_CONTEXT}" port-forward svc/demo-app -n demo 8081:80
