# Workflow GitOps

## Definition

Dans ce projet, GitOps signifie que Git definit l'etat desire du cluster. Argo CD compare cet etat desire avec l'etat reel de Kubernetes et applique les changements necessaires.

## Source de verite

La source de verite est:

- le repository GitHub;
- la branche `main`;
- le chemin cible, par exemple `apps/demo-app/overlays/prod`.

## Exemple de changement

1. modifier `apps/demo-app/overlays/prod/deployment-patch.yaml`;
2. commit et push sur `main`;
3. Argo CD detecte un diff;
4. le `Deployment` est mis a jour.

## Bonnes pratiques

- faire des changements petits et lisibles;
- centraliser le commun dans `base/` et les differences dans `overlays/`;
- eviter les modifications manuelles dans le cluster;
- utiliser des messages de commit explicites.
