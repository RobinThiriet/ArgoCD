# Workflow Normal D'utilisation D'Argo CD

## Objectif

Ce document decrit le workflow normal d'utilisation d'Argo CD dans un projet GitOps, avec une logique simple, pratique et reproductible.

L'idee a retenir est la suivante:

- Git contient l'etat desire;
- Argo CD observe Git;
- Kubernetes applique l'etat decrit;
- l'utilisateur verifie le resultat.

## Principe general

Avec Argo CD, on ne travaille pas d'abord dans le cluster.

On travaille d'abord dans le repository Git.

La sequence normale est donc:

1. identifier le changement a faire;
2. modifier les manifests dans Git;
3. commit et push;
4. laisser Argo CD detecter le changement;
5. verifier la synchronisation et la sante de l'application;
6. tester le resultat.

## Workflow standard au quotidien

### 1. Comprendre le besoin

Avant de modifier quoi que ce soit, il faut clarifier:

- quelle application est concernee;
- quel environnement est concerne;
- si le changement est commun ou specifique a un environnement.

Questions utiles:

- est-ce un changement pour toutes les cibles ou seulement `dev`, `staging` ou `prod` ?
- est-ce un changement de `Deployment`, `Service`, image, replicas, variables d'environnement ?
- est-ce un changement sur `demo-app` ou `hello-app` ?

## 2. Choisir le bon endroit dans le repository

Regle simple:

- changement commun a tous les environnements: modifier `base/`
- changement specifique a un environnement: modifier `overlays/<env>/`
- changement de pilotage Argo CD: modifier `argocd/applications/` ou `argocd/projects/`

Exemples:

- augmenter les replicas en `prod` pour `demo-app`: modifier `apps/demo-app/overlays/prod/`
- changer l'image de `hello-app` partout: modifier `apps/hello-app/base/`
- ajouter une nouvelle application: creer `apps/<app>/` et ses manifests Argo CD

## 3. Valider localement

Avant de commit:

```bash
make validate
```

Cette etape permet de verifier:

- les scripts shell;
- le rendu Kustomize;
- la coherence minimale du repository.

## 4. Committer et pousser

Une fois le changement pret:

```bash
git add .
git commit -m "feat: describe the change"
git push origin main
```

Dans une logique GitOps, tant que le changement n'est pas pousse, il n'existe pas pour Argo CD.

## 5. Argo CD detecte et synchronise

Apres le `git push`, Argo CD:

1. lit le repository GitHub;
2. compare l'etat Git avec l'etat reel du cluster;
3. detecte un diff;
4. applique les manifests manquants ou modifies;
5. reevalue l'etat de sante de l'application.

## 6. Verifier le resultat

Dans Argo CD, les etats importants sont:

- `Synced`: le cluster correspond a Git
- `OutOfSync`: le cluster differe de Git
- `Healthy`: les ressources sont en bon etat
- `Progressing`: le deploiement est en cours
- `Degraded`: une ressource est en erreur

Verification UI:

```bash
make argocd-ui
```

Verification cluster:

```bash
make status
```

## 7. Tester l'application

Pour `demo-app`:

```bash
make demo-ui
make demo-ui APP_ENV=staging
make demo-ui APP_ENV=prod
```

Pour `hello-app`:

```bash
make app-ui APP_NAME=hello-app
make app-ui APP_NAME=hello-app APP_ENV=staging
make app-ui APP_NAME=hello-app APP_ENV=prod
```

## Workflow mental a adopter

La bonne facon de penser avec Argo CD est declarative.

Il ne faut pas penser:

- "je vais modifier le cluster"

Il faut penser:

- "je vais decrire dans Git l'etat que je veux dans le cluster"

Le cluster n'est pas la source de verite.

Git est la source de verite.

Argo CD est le mecanisme de reconciliation entre les deux.

## Methode de decision

Quand tu veux faire un changement, pense toujours dans cet ordre:

1. quel est le besoin ?
2. quelle application est concernee ?
3. quel environnement est concerne ?
4. le changement va-t-il dans `base/` ou dans `overlays/` ?
5. faut-il aussi adapter Argo CD ?
6. comment verifier que le changement est bien applique ?

## Workflow normal dans ce repository

Dans ce projet, le workflow habituel est:

1. modifier une application dans `apps/`
2. lancer `make validate`
3. commit et push
4. laisser Argo CD synchroniser
5. controler dans l'UI Argo CD
6. verifier avec `make status`
7. ouvrir l'application avec `make demo-ui` ou `make app-ui`

## Cas d'usage typiques

### Changer le nombre de replicas en `dev`

Exemple:

```text
apps/demo-app/overlays/dev/deployment-patch.yaml
```

Puis:

```bash
make validate
git add .
git commit -m "feat: scale demo app in dev"
git push origin main
```

## Changer l'image pour tous les environnements

Exemple:

```text
apps/hello-app/base/deployment.yaml
```

Puis:

```bash
make validate
git add .
git commit -m "feat: update hello app image"
git push origin main
```

## Ajouter une nouvelle application

Le workflow est:

1. creer `apps/<nouvelle-app>/base`
2. creer `apps/<nouvelle-app>/overlays/dev|staging|prod`
3. creer les `Application` Argo CD dans `argocd/applications/`
4. valider
5. commit et push
6. lancer si besoin `make gitops-bootstrap-all`

## Ce qu'il faut eviter

- modifier manuellement les ressources dans Kubernetes sans le refléter dans Git
- faire de gros changements non relus
- melanger plusieurs sujets dans un meme commit
- changer `prod` sans avoir valide d'abord `dev` ou `staging`
- oublier de verifier l'etat `Synced` et `Healthy`

## Resume en une phrase

Le workflow normal avec Argo CD est:

```text
Je change Git, je pousse, Argo CD synchronise, je verifie.
```
