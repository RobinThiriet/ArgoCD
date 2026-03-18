CLUSTER_NAME ?= argocd-lab
ARGOCD_NAMESPACE ?= argocd
ARGOCD_VERSION ?= v3.3.4
INGRESS_VERSION ?= controller-v1.14.1
REPO_BRANCH ?= $(shell git branch --show-current 2>/dev/null || echo main)
APP_ENV ?= dev
APP_NAME ?= demo-app

.PHONY: help cluster-up ingress-install hosts-print argocd-install argocd-password argocd-ui gitops-bootstrap gitops-bootstrap-all demo-ui guacamole-ui app-ui status validate destroy

help:
	@printf '%s\n' \
		'Commandes disponibles:' \
		'  make cluster-up        Cree le cluster kind local' \
		'  make ingress-install   Installe ingress-nginx pour les URLs locales' \
		'  make hosts-print       Affiche les entrees /etc/hosts a ajouter' \
		'  make argocd-install    Installe Argo CD dans le cluster' \
		'  make argocd-password   Affiche le mot de passe admin initial' \
		'  make argocd-ui         Ouvre un port-forward vers Argo CD (bloquant)' \
		'  make gitops-bootstrap  Bootstrap toutes les apps d un environnement (defaut: dev)' \
		'  make gitops-bootstrap-all Bootstrap dev, staging et prod' \
		'  make demo-ui           Alias de compatibilite vers demo-app (defaut: dev)' \
		'  make guacamole-ui      Ouvre Guacamole en port-forward (defaut: dev)' \
		'  make app-ui            Ouvre une app locale avec APP_NAME et APP_ENV' \
		'  make status            Affiche l etat general du cluster' \
		'  make validate          Verifie scripts et manifests locaux' \
		'  make destroy           Supprime le cluster kind'

cluster-up:
	@CLUSTER_NAME=$(CLUSTER_NAME) ./scripts/create-cluster.sh

ingress-install:
	@CLUSTER_NAME=$(CLUSTER_NAME) INGRESS_VERSION=$(INGRESS_VERSION) ./scripts/install-ingress-nginx.sh

hosts-print:
	@./scripts/print-local-hosts.sh

argocd-install:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ARGOCD_VERSION=$(ARGOCD_VERSION) ./scripts/install-argocd.sh

argocd-password:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ./scripts/argocd-password.sh

argocd-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) ./scripts/port-forward-argocd.sh

gitops-bootstrap:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) REPO_BRANCH=$(REPO_BRANCH) APP_ENV=$(APP_ENV) ./scripts/bootstrap-gitops.sh

gitops-bootstrap-all:
	@CLUSTER_NAME=$(CLUSTER_NAME) ARGOCD_NAMESPACE=$(ARGOCD_NAMESPACE) REPO_BRANCH=$(REPO_BRANCH) APP_ENV=all ./scripts/bootstrap-gitops.sh

demo-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) APP_ENV=$(APP_ENV) APP_NAME=demo-app ./scripts/port-forward-app.sh

guacamole-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) APP_ENV=$(APP_ENV) APP_NAME=guacamole ./scripts/port-forward-app.sh

app-ui:
	@CLUSTER_NAME=$(CLUSTER_NAME) APP_ENV=$(APP_ENV) APP_NAME=$(APP_NAME) ./scripts/port-forward-app.sh

status:
	@kubectl --context kind-$(CLUSTER_NAME) get nodes
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get pods -n ingress-nginx 2>/dev/null || true
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get pods -n $(ARGOCD_NAMESPACE)
	@printf '\n'
	@kubectl --context kind-$(CLUSTER_NAME) get applications.argoproj.io -n $(ARGOCD_NAMESPACE) 2>/dev/null || true
	@printf '\n'
	@for ns in demo demo-staging demo-prod guacamole guacamole-staging guacamole-prod; do \
		printf '%s\n' "$$ns:"; \
		kubectl --context kind-$(CLUSTER_NAME) get all -n $$ns 2>/dev/null || true; \
		printf '\n'; \
	done

validate:
	@bash -n scripts/*.sh
	@set -e; for app in $$(find apps -mindepth 1 -maxdepth 1 -type d | sort); do \
		kubectl kustomize $$app >/dev/null; \
		kubectl kustomize $$app/base >/dev/null; \
		for overlay in $$app/overlays/*; do \
			kubectl kustomize $$overlay >/dev/null; \
		done; \
	done
	@printf 'Validation locale OK\n'

destroy:
	@kind delete cluster --name $(CLUSTER_NAME)
