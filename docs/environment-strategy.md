# Environment Strategy

## Objectif

Le projet adopte maintenant une structure multi-environnements afin de preparer une organisation plus proche d'un contexte reel, tout en gardant un point d'entree simple pour l'apprentissage.

## Principe

Chaque application du repository est decoupee en:

- une `base` commune;
- des `overlays` par environnement.

Structure:

```text
apps/<application>/
  base/
  overlays/
    dev/
    staging/
    prod/
```

## Pourquoi cette approche

- la `base` porte les manifests communs;
- chaque `overlay` exprime les differences minimales;
- l'evolution vers plusieurs environnements devient naturelle;
- Argo CD peut cibler chaque environnement avec une `Application` dediee.

## Mapping actuel

Le mapping suivant s'applique a chaque application (`demo-app` et `hello-app`):

| Environnement | Overlay | Namespace | Application Argo CD |
| --- | --- | --- | --- |
| `dev` | `apps/<application>/overlays/dev` | `demo` | `<application>-dev` |
| `staging` | `apps/<application>/overlays/staging` | `demo-staging` | `<application>-staging` |
| `prod` | `apps/<application>/overlays/prod` | `demo-prod` | `<application>-prod` |

## Garde-fou debutant

Pour ne pas compliquer le parcours initial:

- `make gitops-bootstrap` cible `dev` par defaut;
- `make demo-ui` cible `dev` par defaut;
- `make app-ui APP_NAME=hello-app` ouvre la seconde application;
- `apps/demo-app/kustomization.yaml` et `apps/hello-app/kustomization.yaml` restent des points d'entree simples et pointent vers `dev`.

Ainsi, un debutant peut continuer a suivre le lab sans se confronter tout de suite a la complexite multi-environnements.

## Commandes utiles

Bootstrap `dev`:

```bash
make gitops-bootstrap
```

Bootstrap `staging`:

```bash
make gitops-bootstrap APP_ENV=staging
```

Bootstrap `prod`:

```bash
make gitops-bootstrap APP_ENV=prod
```

Bootstrap de tous les environnements:

```bash
make gitops-bootstrap-all
```

Port-forward `dev`:

```bash
make demo-ui
make app-ui APP_NAME=hello-app
```

Port-forward `staging`:

```bash
make demo-ui APP_ENV=staging
make app-ui APP_NAME=hello-app APP_ENV=staging
```

Port-forward `prod`:

```bash
make demo-ui APP_ENV=prod
make app-ui APP_NAME=hello-app APP_ENV=prod
```
