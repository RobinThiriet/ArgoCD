# Target Structure

## Objectif

Le depot courant supporte deja `base/overlays` et plusieurs environnements. Ce document decrit la cible de maturite pour un bastion Guacamole maintenable, plus securise et plus simple a faire evoluer.

## Structure cible

```text
.
|-- .github/
|-- Makefile
|-- README.md
|-- CONTRIBUTING.md
|-- apps
|   `-- guacamole
|       |-- base
|       `-- overlays
|           |-- dev
|           |-- staging
|           `-- prod
|-- argocd
|   |-- projects
|   |   `-- bastion-project.yaml
|   `-- applications
|       |-- guacamole-dev.yaml
|       |-- guacamole-staging.yaml
|       `-- guacamole-prod.yaml
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
- le bastion reste lisible, meme quand on ajoute TLS, SAML ou une vraie gestion des secrets.

## Chemin de migration recommande

1. conserver le fonctionnement simple pour `dev`;
2. ajouter TLS sur l'Ingress;
3. introduire une gestion de secrets GitOps-compatible;
4. activer SAML et les variables associees;
5. introduire une pipeline CI plus riche;
6. envisager `ApplicationSet` si la plateforme se duplique pour d'autres bastions.

## Pourquoi garder des points d'entree simples

Bien que le projet soit passe a `dev/staging/prod`, il conserve des points d'entree debutants:

- `make gitops-bootstrap` cible `dev`;
- `make guacamole-ui` cible `dev`;
- `apps/guacamole/kustomization.yaml` pointe vers l'overlay `dev`.
