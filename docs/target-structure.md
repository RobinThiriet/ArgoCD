# Target Structure

## Objectif

Le depot courant supporte deja `base/overlays` et plusieurs environnements. Ce document decrit maintenant la prochaine marche de maturite pour accompagner la croissance vers plusieurs applications, plus de standardisation et davantage d'automatisation.

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
|   |   `-- overlays
|   |       |-- dev
|   |       |-- staging
|   |       `-- prod
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

1. conserver le fonctionnement simple pour `dev`;
2. ajouter une seconde application;
3. factoriser davantage les conventions entre applications;
4. envisager `ApplicationSet` si le nombre de cibles augmente;
5. introduire une pipeline CI plus riche;
6. ajouter la gestion des secrets et politiques.

## Pourquoi garder des points d'entree simples

Bien que le projet soit passe a `dev/staging/prod`, il conserve des points d'entree debutants:

- `make gitops-bootstrap` cible `dev`;
- `make demo-ui` cible `dev`;
- `apps/demo-app/kustomization.yaml` pointe vers l'overlay `dev`.
