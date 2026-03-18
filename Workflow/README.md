# Workflow Normal D'utilisation D'Argo CD

## Objectif

Ce document decrit le workflow normal d'utilisation d'Argo CD dans cette branche, centree sur un seul Guacamole.

## Sequence normale

1. identifier le changement a faire
2. modifier les manifests dans `apps/guacamole`
3. lancer `make validate`
4. commit et push
5. laisser Argo CD synchroniser
6. verifier l'etat `Synced` et `Healthy`
7. tester sur `http://guacamole.local`

## Logique a adopter

Avec Argo CD, on ne pense pas:

- "je vais modifier le cluster"

On pense:

- "je vais decrire dans Git l'etat que je veux"

Git est la source de verite.

## Endroits utiles dans le repository

- `apps/guacamole/base/` pour les manifests communs
- `apps/guacamole/kustomization.yaml` pour le point d'entree deploye
- `argocd/applications/guacamole.yaml` pour l'application Argo CD
- `argocd/projects/bastion-project.yaml` pour le perimetre Argo CD

## Commandes quotidiennes

```bash
make validate
git add .
git commit -m "feat: describe the change"
git push origin feat/guacamole-bastion
make status
```

## Resume

```text
Je change Git, je pousse, Argo CD synchronise, je verifie sur guacamole.local.
```
