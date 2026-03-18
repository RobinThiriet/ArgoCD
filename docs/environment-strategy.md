# Environment Strategy

## Strategie actuelle

Le projet ne separe plus `dev`, `staging` et `prod`.

Il repose maintenant sur un seul environnement de travail:

| Element | Valeur |
| --- | --- |
| Namespace | `guacamole` |
| Application Argo CD | `guacamole` |
| URL | `http://guacamole.local` |
| Path Git | `apps/guacamole` |

## Pourquoi ce choix

- reduire la complexite
- travailler directement sur une seule plateforme
- accelerer les iterations GitOps

## Evolution possible plus tard

Si tu veux remettre des environnements plus tard, la structure `base/` est deja la et pourra a nouveau accueillir des overlays.
