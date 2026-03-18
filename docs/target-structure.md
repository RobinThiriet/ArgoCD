# Target Structure

## Objectif

Le depot courant est volontairement simple. Ce document decrit une structure cible plus mature pour accompagner la croissance du projet vers plusieurs applications et plusieurs environnements.

## Structure cible

```text
.
|-- .github/
|-- Makefile
|-- README.md
|-- CONTRIBUTING.md
|-- apps
|   |-- demo-app
|   |   |-- base
|   |   |   |-- deployment.yaml
|   |   |   |-- service.yaml
|   |   |   `-- kustomization.yaml
|   |   `-- overlays
|   |       |-- dev
|   |       |   `-- kustomization.yaml
|   |       |-- staging
|   |       |   `-- kustomization.yaml
|   |       `-- prod
|   |           `-- kustomization.yaml
|   `-- second-app
|       `-- ...
|-- argocd
|   |-- projects
|   |   `-- demo-project.yaml
|   `-- applications
|       |-- demo-app-dev.yaml
|       |-- demo-app-staging.yaml
|       `-- demo-app-prod.yaml
|-- docs
|   |-- architecture.md
|   |-- repository-standards.md
|   |-- target-structure.md
|   `-- ...
`-- scripts
    `-- ...
```

## Principes de la structure cible

- `base/` porte les manifests communs;
- `overlays/` porte les variations par environnement;
- `argocd/projects/` centralise les `AppProject`;
- `argocd/applications/` decrit les applications par environnement;
- chaque application reste isolee et lisible.

## Chemin de migration recommande

1. conserver l'application actuelle telle quelle pour la phase d'apprentissage;
2. introduire `base/` et `overlays/dev`;
3. ajouter `staging` et `prod`;
4. separer `argocd/` en `projects/` et `applications/`;
5. introduire une seconde application;
6. envisager `ApplicationSet` si le nombre de cibles augmente.

## Pourquoi ne pas l'imposer des maintenant

La structure cible serait trop lourde pour un premier contact avec Argo CD. Le depot reste donc volontairement simple au debut, tout en rendant explicite la trajectoire d'evolution.
