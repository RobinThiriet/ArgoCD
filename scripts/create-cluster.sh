#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-argocd-lab}"
WAIT_TIME="${WAIT_TIME:-120s}"
KIND_CONFIG="${KIND_CONFIG:-kind/cluster-config.yaml}"

if kind get clusters | grep -qx "${CLUSTER_NAME}"; then
  echo "Le cluster kind '${CLUSTER_NAME}' existe deja."
else
  echo "Creation du cluster kind '${CLUSTER_NAME}'..."
  kind create cluster --name "${CLUSTER_NAME}" --config "${KIND_CONFIG}" --wait "${WAIT_TIME}"
fi

kubectl cluster-info --context "kind-${CLUSTER_NAME}"
