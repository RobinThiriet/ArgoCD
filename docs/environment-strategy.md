# Environment Strategy

## Strategie actuelle

Le projet ne separe plus `dev`, `staging` et `prod`.

Il repose sur un seul environnement de travail, plus simple a maintenir et plus direct pour un usage de bastion local.

| Element | Valeur |
| --- | --- |
| Namespace applicatif | `guacamole` |
| Application Argo CD | `guacamole` |
| URL Guacamole | `http://guacamole.local` |
| URL Argo CD | `http://argocd.local` |
| Path Git | `apps/guacamole` |

## Pourquoi ce choix

- reduire la complexite operationnelle;
- travailler directement sur une seule plateforme;
- accelerer les iterations GitOps;
- garder un parcours d'apprentissage lisible.

## Evolution possible plus tard

Si plusieurs environnements deviennent necessaires, la structure `base/` pourra etre enrichie avec des overlays dedies.
