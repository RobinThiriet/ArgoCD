# Application Catalog

## Objectif

Ce document decrit l'unique application portee par cette branche: le bastion Guacamole.

## Application disponible

### `guacamole`

- role: bastion d'acces distant web;
- images: `guacamole/guacamole:1.6.0`, `guacamole/guacd:1.6.0`, `postgres:16-alpine`;
- service: `svc/guacamole`;
- namespaces cibles: `guacamole`, `guacamole-staging`, `guacamole-prod`;
- acces Ingress: `guacamole.local`, `guacamole-staging.local`, `guacamole-prod.local`.

## Applications Argo CD generees

| Environnement | Applications |
| --- | --- |
| `dev` | `guacamole-dev` |
| `staging` | `guacamole-staging` |
| `prod` | `guacamole-prod` |

## Acces local

### `guacamole`

Acces Ingress recommande:

- `http://guacamole.local`
- `http://guacamole-staging.local`
- `http://guacamole-prod.local`

Acces port-forward de secours:

```bash
make guacamole-ui
make guacamole-ui APP_ENV=staging
make guacamole-ui APP_ENV=prod
```

Ports par defaut:

- `8281` pour `dev`
- `8282` pour `staging`
- `8283` pour `prod`

## Convention de nommage

Pour garder un bootstrap evolutif, les manifests Argo CD suivent la convention:

```text
<app-name>-<environment>.yaml
```

Exemples:

- `guacamole-dev.yaml`
- `guacamole-staging.yaml`
- `guacamole-prod.yaml`

Le script de bootstrap peut ainsi appliquer automatiquement toutes les applications d'un environnement donne.
