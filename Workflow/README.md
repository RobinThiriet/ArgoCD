# Workflow Normal D'utilisation D'Argo CD

## Objectif

Ce document decrit le workflow normal d'utilisation d'Argo CD dans ce repository GitOps.

## Principe general

Avec Argo CD, on travaille d'abord dans Git:

1. identifier le changement a faire;
2. modifier les manifests dans le repository;
3. commit et push;
4. laisser Argo CD detecter le changement;
5. verifier la synchronisation et la sante de l'application.

## Choisir le bon endroit

- changement commun: modifier `base/`
- changement specifique a l'environnement actif: modifier `overlays/prod/`
- changement de pilotage Argo CD: modifier `argocd/applications/` ou `argocd/projects/`

Exemples:

- augmenter les replicas en `prod` pour `demo-app`: modifier `apps/demo-app/overlays/prod/`
- changer l'image de `hello-app` partout: modifier `apps/hello-app/base/`
- ajouter une nouvelle application: creer `apps/<app>/` et son manifeste Argo CD

## Validation locale

```bash
make validate
```

## Tester l'application

Pour `demo-app`:

```bash
make demo-ui
```

Pour `hello-app`:

```bash
make app-ui APP_NAME=hello-app
```

## Cas d'usage typique

Exemple de changement de replicas:

```text
apps/demo-app/overlays/prod/deployment-patch.yaml
```

Puis:

```bash
make validate
git add .
git commit -m "feat: scale demo app in prod"
git push origin main
```

## Ce qu'il faut eviter

- modifier manuellement les ressources dans Kubernetes sans le refleter dans Git;
- faire de gros changements non relus;
- melanger plusieurs sujets dans un meme commit;
- oublier de verifier l'etat `Synced` et `Healthy`.
