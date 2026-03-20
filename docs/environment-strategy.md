# Environment Strategy

## Objectif

La branche `main` est volontairement simplifiee autour d'un seul environnement afin de garder un parcours GitOps plus lisible.

## Principe

Chaque application du repository est decoupee en:

- une `base` commune;
- un `overlay` actif pour `prod`.

Structure:

```text
apps/<application>/
  base/
  overlays/
    prod/
```

## Mapping actuel

| Environnement | Overlay | Namespace | Application Argo CD |
| --- | --- | --- | --- |
| `prod` | `apps/<application>/overlays/prod` | `demo-prod` | `<application>-prod` |

## Commandes utiles

Bootstrap `prod`:

```bash
make gitops-bootstrap
make gitops-bootstrap APP_ENV=prod
```

Bootstrap de toutes les applications declarees:

```bash
make gitops-bootstrap-all
```

Port-forward `prod`:

```bash
make demo-ui
make app-ui APP_NAME=hello-app
```
