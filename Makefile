CLUSTER_NAME ?= argocd-lab
ARGOCD_NAMESPACE ?= argocd
ARGOCD_VERSION ?= v3.3.4
REPO_BRANCH ?= main

.PHONY: help cluster-up argocd-install argocd-password argocd-ui gitops-bootstrap demo-ui status validate destroy

help:
	@printf '%s\n' \
	'Commandes disponibles:' \
	'  make cluster-up        Cree le cluster kind local' \
	'  make argocd-install    Installe Argo CD dans le cluster' \
	'  make argocd-password   Affiche le mot de passe admin initial' \
		'  make argocd-ui         Ouvre un port-forward vers Argo CD (bloquant)' \
		'  make gitops-bootstrap  Applique le projet et l application Argo CD' \
		'  make demo-ui           Ouvre un port-forward vers l app de demo (bloquant)' \
		'  make status            Affiche l etat general du cluster' \
		'  make validate          Verifie scripts et manifests locaux' \
		'  make destroy           Supprime le cluster kind'

cluster-up:
	@CLUSTER_NAME=$(CLUSTER_NAME) ./scripts/create-cluster.sh

argocd-install:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ARGOCD_VERSION=$(ARGOCD_VERSION) ./scripts/install-argocd.sh

argocd-password:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ./scripts/argocd-password.sh

argocd-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ./scripts/port-forward-argocd.sh

gitops-bootstrap:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) REPO_BRANCH=$(REPO_BRANCH) ./scripts/bootstrap-gitops.sh

demo-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) ./scripts/port-forward-demo.sh

status:
	@kubectl --context kind-$(CLUSTER_NAME) get nodes
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get pods -n $(ARGOCD_NAMESPACE)
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get applications.argoproj.io -n $(ARGOCD_NAMESPACE) 2>/dev/null || true
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get all -n demo 2>/dev/null || true

validate:
	@bash -n scripts/*.sh
	@kubectl kustomize apps/demo-app >/dev/null
	@printf 'Validation locale OK\n'

destroy:
	@kind delete cluster --name $(CLUSTER_NAME)
