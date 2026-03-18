#!/usr/bin/env bash
set -euo pipefail

ARGOCD_NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"

echo "Argo CD est accessible sur https://localhost:8080"
kubectl --context "${KUBE_CONTEXT}" port-forward svc/argocd-server -n "${ARGOCD_NAMESPACE}" 8080:443
