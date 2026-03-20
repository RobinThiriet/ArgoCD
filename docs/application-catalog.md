# Application Catalog

## Objectif

Ce document decrit les applications presentes dans le repository et leur cible actuelle sur `main`.

## Applications disponibles

### `demo-app`

- role: application principale de demonstration;
- image: `traefik/whoami:v1.10.1`;
- service: `svc/demo-app`;
- namespace cible: `demo-prod`.

### `hello-app`

- role: seconde application d'exemple;
- image: `nginxdemos/hello:0.4`;
- service: `svc/hello-app`;
- namespace cible: `demo-prod`.

## Applications Argo CD generees

| Environnement | Applications |
| --- | --- |
| `prod` | `demo-app-prod`, `hello-app-prod` |

## Acces local

### `demo-app`

```bash
make demo-ui
```

Port par defaut: `8083`

### `hello-app`

```bash
make app-ui APP_NAME=hello-app
```

Port par defaut: `8183`

## Convention de nommage

Les manifests Argo CD suivent la convention:

```text
<app-name>-<environment>.yaml
```

Exemples:

- `demo-app-prod.yaml`
- `hello-app-prod.yaml`
