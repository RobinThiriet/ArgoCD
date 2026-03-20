# Getting Started

## Objectif

Ce guide permet de lancer le lab de bout en bout sur un poste local.

## Prerequis

- Docker fonctionnel
- `kubectl`
- `kind`
- `git`
- `make`

Verification rapide:

```bash
docker --version
kubectl version --client=true
kind version
git --version
make --version
```

## Etape 1 - Creer le cluster

```bash
make cluster-up
```

Resultat attendu:

- un cluster `kind` nomme `argocd-lab`;
- un contexte Kubernetes `kind-argocd-lab`;
- un namespace cible `demo-prod`.

## Etape 2 - Installer Argo CD

```bash
make argocd-install
```

Verification:

```bash
make status
```

## Etape 3 - Recuperer le mot de passe admin

```bash
make argocd-password
```

## Etape 4 - Ouvrir l'UI Argo CD

```bash
make argocd-ui
```

Puis ouvrir `https://localhost:8080`.

## Etape 5 - Pousser le contenu du repository

```bash
git add .
git commit -m "chore: bootstrap argocd lab"
git push origin main
```

## Etape 6 - Bootstrap GitOps

```bash
make gitops-bootstrap
```

Resultat attendu:

- `demo-project` cree dans Argo CD;
- `demo-app-prod` cree dans Argo CD;
- `hello-app-prod` cree dans Argo CD;
- namespace `demo-prod` cree automatiquement lors de la sync.

## Etape 7 - Ouvrir les applications

```bash
make demo-ui
make app-ui APP_NAME=hello-app
```

Acces:

- `http://localhost:8083`
- `http://localhost:8183`

## Etape 8 - Tester un changement GitOps

Modifier [`apps/demo-app/overlays/prod/deployment-patch.yaml`](/root/ArgoCD/apps/demo-app/overlays/prod/deployment-patch.yaml#L1), puis:

```bash
git add apps/demo-app/overlays/prod/deployment-patch.yaml
git commit -m "feat: scale demo app"
git push origin main
```

Verification:

- dans l'UI Argo CD, l'application doit repasser en `Synced`;
- dans Kubernetes, le nombre de replicas doit evoluer.
