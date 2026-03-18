# Environment Strategy

## Objectif

Le projet adopte maintenant une structure multi-environnements afin de preparer une organisation plus proche d'un contexte reel, tout en gardant un point d'entree simple pour l'apprentissage.

## Principe

L'application `demo-app` est decoupee en:

- une `base` commune;
- des `overlays` par environnement.

Structure:

```text
apps/demo-app/
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

| Environnement | Overlay | Namespace | Application Argo CD |
| --- | --- | --- | --- |
| `dev` | `apps/demo-app/overlays/dev` | `demo` | `demo-app-dev` |
| `staging` | `apps/demo-app/overlays/staging` | `demo-staging` | `demo-app-staging` |
| `prod` | `apps/demo-app/overlays/prod` | `demo-prod` | `demo-app-prod` |

## Garde-fou debutant

Pour ne pas compliquer le parcours initial:

- `make gitops-bootstrap` cible `dev` par defaut;
- `make demo-ui` cible `dev` par defaut;
- `apps/demo-app/kustomization.yaml` reste un point d'entree simple et pointe vers l'overlay `dev`.

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
```

Port-forward `staging`:

```bash
make demo-ui APP_ENV=staging
```

Port-forward `prod`:

```bash
make demo-ui APP_ENV=prod
```
