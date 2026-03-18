# Getting Started

## Objectif

Ce guide permet de lancer le bastion Guacamole de bout en bout sur un poste local.

## Prerequis

- Docker fonctionnel
- `kubectl`
- `kind`
- `git`
- `make`

Verification rapide:

```bash
docker --version
kubectl version --client=true
kind version
git --version
make --version
```

## Etape 1 - Creer le cluster

```bash
make cluster-up
```

Resultat attendu:

- un cluster `kind` nomme `argocd-lab`;
- un contexte Kubernetes `kind-argocd-lab`;
- une base prete a accueillir `dev`, `staging` et `prod` via Ingress local.

## Etape 2 - Installer l'Ingress

```bash
make ingress-install
```

Puis afficher les entrees hosts a ajouter:

```bash
make hosts-print
```

Ajoute ensuite dans `/etc/hosts`:

```text
127.0.0.1 guacamole.local
127.0.0.1 guacamole-staging.local
127.0.0.1 guacamole-prod.local
```

## Etape 3 - Installer Argo CD

```bash
make argocd-install
```

Verification:

```bash
make status
```

Tous les pods du namespace `argocd` doivent etre `Running`.

## Etape 4 - Recuperer le mot de passe admin

```bash
make argocd-password
```

Conserve la valeur retourne pour la connexion initiale.

## Etape 5 - Ouvrir l'UI Argo CD

Dans un terminal dedie:

```bash
make argocd-ui
```

Puis ouvrir:

```text
https://localhost:8080
```

Identifiants:

- login: `admin`
- password: sortie de `make argocd-password`

## Etape 6 - Pousser le contenu du repository

Le bootstrap GitOps refuse de continuer si le depot n'est pas propre ou pas synchronise avec la branche distante suivie.

```bash
git add .
git commit -m "chore: bootstrap guacamole bastion"
git push origin feat/guacamole-bastion
```

## Etape 7 - Bootstrap GitOps

```bash
make gitops-bootstrap
```

Resultat attendu:

- `bastion-project` cree dans Argo CD;
- `guacamole-dev` cree dans Argo CD;
- namespace `guacamole` cree automatiquement lors de la sync;
- application synchronisee automatiquement.

Pour les autres environnements:

```bash
make gitops-bootstrap APP_ENV=staging
make gitops-bootstrap APP_ENV=prod
make gitops-bootstrap-all
```

## Etape 8 - Ouvrir Guacamole

Mode Ingress recommande:

```text
http://guacamole.local
```

Mode port-forward si besoin:

Dans un second terminal:

```bash
make guacamole-ui
```

Puis ouvrir:

```text
http://localhost:8281
```

## Etape 9 - Tester un vrai changement GitOps

Modifier [`apps/guacamole/overlays/dev/secret-patch.yaml`](/root/ArgoCD/apps/guacamole/overlays/dev/secret-patch.yaml#L1):

```yaml
POSTGRES_PASSWORD: CHANGE_ME_GUACAMOLE_DEV_DB_PASSWORD_V2
```

Ensuite:

```bash
git add apps/guacamole/overlays/dev/secret-patch.yaml
git commit -m "feat: rotate guacamole dev db password"
git push origin feat/guacamole-bastion
```

Verification:

- dans l'UI Argo CD, l'application doit repasser en `Synced`;
- dans Kubernetes, le `Secret` et les pods doivent refléter le changement.

Commande utile:

```bash
kubectl --context kind-argocd-lab -n guacamole get all
```
