# Application Catalog

## Objectif

Ce document decrit les applications actuellement presentes dans le repository afin de montrer comment le lab GitOps passe d'une demonstration simple a un depot multi-applications.

## Applications disponibles

### `demo-app`

- role: application principale de demonstration;
- image: `traefik/whoami:v1.10.1`;
- service: `svc/demo-app`;
- namespaces cibles: `demo`, `demo-staging`, `demo-prod`.

### `hello-app`

- role: seconde application d'exemple pour illustrer la montee en charge du depot;
- image: `nginxdemos/hello:0.4`;
- service: `svc/hello-app`;
- namespaces cibles: `demo`, `demo-staging`, `demo-prod`.

### `guacamole`

- role: bastion d'acces distant web;
- images: `guacamole/guacamole:1.6.0`, `guacamole/guacd:1.6.0`, `postgres:16-alpine`;
- service: `svc/guacamole`;
- namespaces cibles: `guacamole`, `guacamole-staging`, `guacamole-prod`;
- acces Ingress: `guacamole.local`, `guacamole-staging.local`, `guacamole-prod.local`.

## Applications Argo CD generees

| Environnement | Applications |
| --- | --- |
| `dev` | `demo-app-dev`, `hello-app-dev`, `guacamole-dev` |
| `staging` | `demo-app-staging`, `hello-app-staging`, `guacamole-staging` |
| `prod` | `demo-app-prod`, `hello-app-prod`, `guacamole-prod` |

## Acces local

### `demo-app`

```bash
make demo-ui
make demo-ui APP_ENV=staging
make demo-ui APP_ENV=prod
```

Ports par defaut:

- `8081` pour `dev`
- `8082` pour `staging`
- `8083` pour `prod`

### `hello-app`

```bash
make app-ui APP_NAME=hello-app
make app-ui APP_NAME=hello-app APP_ENV=staging
make app-ui APP_NAME=hello-app APP_ENV=prod
```

Ports par defaut:

- `8181` pour `dev`
- `8182` pour `staging`
- `8183` pour `prod`

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

- `demo-app-dev.yaml`
- `guacamole-dev.yaml`
- `hello-app-staging.yaml`
- `hello-app-prod.yaml`

Le script de bootstrap peut ainsi appliquer automatiquement toutes les applications d'un environnement donne.
