# Repository Standards

## Objectif

Ce document fixe les standards de structure et de contribution du depot.

## Standards de structure

Exemple:

```text
apps/
  demo-app/
    base/
    overlays/
      prod/
```

La regle generale est:

- `base/` pour le commun;
- `overlays/` pour les differences par environnement.

## Standards de validation

La commande minimale de validation locale est:

```bash
make validate
```
