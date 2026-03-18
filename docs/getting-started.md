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
- une base prete a accueillir `dev`, `staging` et `prod`.

## Etape 2 - Installer Argo CD

```bash
make argocd-install
```

Verification:

```bash
make status
```

Tous les pods du namespace `argocd` doivent etre `Running`.

## Etape 3 - Recuperer le mot de passe admin

```bash
make argocd-password
```

Conserve la valeur retourne pour la connexion initiale.

## Etape 4 - Ouvrir l'UI Argo CD

Dans un terminal dedie:

```bash
make argocd-ui
```

Puis ouvrir:

```text
https://localhost:8080
```

Identifiants:

- login: `admin`
- password: sortie de `make argocd-password`

## Etape 5 - Pousser le contenu du repository

Le bootstrap GitOps refuse de continuer si le depot n'est pas propre ou pas synchronise avec `origin/main`.

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
- `demo-app-dev` cree dans Argo CD;
- `hello-app-dev` cree dans Argo CD;
- namespace `demo` cree automatiquement lors de la sync;
- application synchronisee automatiquement.

Pour les autres environnements:

```bash
make gitops-bootstrap APP_ENV=staging
make gitops-bootstrap APP_ENV=prod
make gitops-bootstrap-all
```

## Etape 7 - Ouvrir l'application de demonstration

Dans un second terminal:

```bash
make demo-ui
```

Puis ouvrir:

```text
http://localhost:8081
```

Pour la seconde application:

```bash
make app-ui APP_NAME=hello-app
```

Puis ouvrir:

```text
http://localhost:8181
```

## Etape 8 - Tester un vrai changement GitOps

Modifier [`apps/demo-app/overlays/dev/deployment-patch.yaml`](/root/ArgoCD/apps/demo-app/overlays/dev/deployment-patch.yaml#L1):

```yaml
spec:
  replicas: 3
```

Ensuite:

```bash
git add apps/demo-app/overlays/dev/deployment-patch.yaml
git commit -m "feat: scale demo app"
git push origin main
```

Verification:

- dans l'UI Argo CD, l'application doit repasser en `Synced`;
- dans Kubernetes, le nombre de replicas doit evoluer.

Commande utile:

```bash
kubectl --context kind-argocd-lab -n demo get deploy demo-app
```
