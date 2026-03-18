# Getting Started

## Objectif

Ce guide permet de lancer le bastion Guacamole de bout en bout sur un poste local.

## Prerequis

- Docker
- `kubectl`
- `kind`
- `git`
- `make`

## Etape 1 - Creer le cluster

```bash
make cluster-up
```

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

## Etape 3 - Installer Argo CD

```bash
make argocd-install
make argocd-password
```

Interface Argo CD:

```text
http://argocd.local
```

## Etape 4 - Pousser le repository

```bash
git add .
git commit -m "chore: simplify guacamole platform"
git push origin feat/guacamole-bastion
```

## Etape 5 - Bootstrap GitOps

```bash
make gitops-bootstrap
```

Resultat attendu:

- `bastion-project` cree dans Argo CD
- `guacamole` cree dans Argo CD
- namespace `guacamole` cree automatiquement

## Etape 6 - Ouvrir Guacamole

Acces recommande:

```text
http://guacamole.local
```

Acces port-forward:

```bash
make guacamole-ui
```

## Etape 7 - Tester un changement GitOps

Modifier [`apps/guacamole/base/secret.yaml`](/root/ArgoCD/apps/guacamole/base/secret.yaml#L1), puis:

```bash
make validate
git add .
git commit -m "feat: update guacamole db secret"
git push origin feat/guacamole-bastion
```
