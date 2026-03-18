# Environment Strategy

## Objectif

Le projet adopte une structure multi-environnements pour decrire un bastion Guacamole plus realiste, tout en gardant un parcours lisible pour un debutant.

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

Le mapping suivant s'applique a Guacamole:

| Environnement | Overlay | Namespace | Application Argo CD |
| --- | --- | --- | --- |
| `dev` | `apps/guacamole/overlays/dev` | `guacamole` | `guacamole-dev` |
| `staging` | `apps/guacamole/overlays/staging` | `guacamole-staging` | `guacamole-staging` |
| `prod` | `apps/guacamole/overlays/prod` | `guacamole-prod` | `guacamole-prod` |

## Garde-fou debutant

Pour ne pas compliquer le parcours initial:

- `make gitops-bootstrap` cible `dev` par defaut;
- `make guacamole-ui` cible `dev` par defaut;
- `apps/guacamole/kustomization.yaml` reste un point d'entree simple et pointe vers `dev`.

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
make guacamole-ui
```

Port-forward `staging`:

```bash
make guacamole-ui APP_ENV=staging
```

Port-forward `prod`:

```bash
make guacamole-ui APP_ENV=prod
```
