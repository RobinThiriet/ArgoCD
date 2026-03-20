# Target Structure

## Structure cible

```text
.
|-- apps
|   `-- guacamole
|       |-- base
|       `-- kustomization.yaml
|-- argocd
|   |-- applications
|   |   `-- guacamole.yaml
|   `-- projects
|       `-- bastion-project.yaml
|-- docs
|-- Workflow
`-- scripts
```

## Evolution recommandee

1. garder une seule plateforme tant que tu apprends
2. ajouter TLS
3. ajouter SAML
4. introduire une vraie gestion des secrets
