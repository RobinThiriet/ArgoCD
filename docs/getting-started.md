# Getting Started

## Objectif

Ce guide permet de lancer le bastion Guacamole de bout en bout sur un poste local, avec un ordre d'execution clair et des verifications a chaque etape.

## Prerequis

- Docker
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
- les ports `80` et `443` exposes localement pour l'Ingress.

## Etape 2 - Installer l'Ingress

```bash
make ingress-install
make hosts-print
```

Ajouter ensuite dans `/etc/hosts`:

```text
127.0.0.1 argocd.local
127.0.0.1 guacamole.local
```

Verification utile:

```bash
kubectl --context kind-argocd-lab -n ingress-nginx get pods
```

## Etape 3 - Installer Argo CD

```bash
make argocd-install
make argocd-password
```

Acces Argo CD:

```text
http://argocd.local
```

Verification utile:

```bash
kubectl --context kind-argocd-lab -n argocd get pods
```

## Etape 4 - Pousser le repository

```bash
git add .
git commit -m "chore: update guacamole bastion"
git push origin feat/guacamole-bastion
```

Le bootstrap GitOps ne continue que si le depot local est propre et synchronise avec `origin/feat/guacamole-bastion`.

## Etape 5 - Bootstrap GitOps

```bash
make gitops-bootstrap
```

Resultat attendu:

- `bastion-project` cree dans Argo CD;
- `guacamole` cree dans Argo CD;
- namespace `guacamole` cree automatiquement;
- application `Synced` puis `Healthy`.

Verification utile:

```bash
kubectl --context kind-argocd-lab -n argocd get applications.argoproj.io
kubectl --context kind-argocd-lab -n guacamole get all
```

## Etape 6 - Ouvrir Guacamole

Acces recommande:

```text
http://guacamole.local
```

Acces port-forward de secours:

```bash
make guacamole-ui
```

## Etape 7 - Connexion initiale

Identifiants par defaut:

- utilisateur: `guacadmin`;
- mot de passe: `guacadmin`.

Action recommandee:

- changer immediatement le mot de passe administrateur.

## Etape 8 - Tester un changement GitOps

Modifier par exemple [`apps/guacamole/base/ingress.yaml`](/root/ArgoCD/apps/guacamole/base/ingress.yaml), puis:

```bash
make validate
git add .
git commit -m "feat: update guacamole configuration"
git push origin feat/guacamole-bastion
```

Verification:

- dans Argo CD, l'application doit repasser en `Synced`;
- dans Kubernetes, la ressource modifiee doit etre reconciliee;
- l'acces `http://guacamole.local` doit rester fonctionnel.
