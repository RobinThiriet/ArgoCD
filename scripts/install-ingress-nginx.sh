#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
KUBE_CONTEXT="kind-${CLUSTER_NAME}"
INGRESS_VERSION="${INGRESS_VERSION:-controller-v1.14.1}"
INGRESS_URL="https://raw.githubusercontent.com/kubernetes/ingress-nginx/${INGRESS_VERSION}/deploy/static/provider/kind/deploy.yaml"

echo "Installation d'ingress-nginx ${INGRESS_VERSION}..."
kubectl --context "${KUBE_CONTEXT}" apply -f "${INGRESS_URL}"

echo "Attente du controleur ingress-nginx..."
kubectl --context "${KUBE_CONTEXT}" wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

echo "ingress-nginx est installe."
