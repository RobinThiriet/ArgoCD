# Workflow Guacamole Bastion

## Objectif

Ce guide decrit le workflow normal pour deployer et exploiter le bastion Guacamole dans cette branche `feat/guacamole-bastion`.

## Ce que deploie cette branche

- `guacamole`
- `guacd`
- `postgresql`
- des `Secret` Kubernetes avec placeholders documentes
- un `Ingress` pour chaque environnement
- des namespaces dedies:
  - `guacamole`
  - `guacamole-staging`
  - `guacamole-prod`

## URLs locales

- `http://guacamole.local`
- `http://guacamole-staging.local`
- `http://guacamole-prod.local`

## 1. Recreer le cluster local

Cette branche ajoute un cluster `kind` configure pour exposer les ports `80` et `443`, necessaires a l'Ingress.

```bash
make destroy
make cluster-up
make ingress-install
make argocd-install
```

## 2. Ajouter les entrees hosts

Afficher les lignes a ajouter:

```bash
make hosts-print
```

Puis ajouter dans `/etc/hosts`:

```text
127.0.0.1 guacamole.local
127.0.0.1 guacamole-staging.local
127.0.0.1 guacamole-prod.local
```

## 3. Comprendre les secrets placeholders

Les `Secret` versionnes dans Git contiennent des valeurs de type:

```text
CHANGE_ME_GUACAMOLE_DEV_DB_PASSWORD
```

Le but est:

- de garder le repository publiable;
- de ne pas exposer de vrai mot de passe;
- d'avoir une structure GitOps complete des maintenant.

Pour un lab local, ces placeholders fonctionnent techniquement.

Pour un environnement plus serieux, il faut les remplacer.

## 4. Bootstrap GitOps

Pour deployer toutes les applications de tous les environnements:

```bash
make gitops-bootstrap-all
```

Pour ne deployer que Guacamole en `dev`, `staging` ou `prod`, Argo CD utilisera les manifests de:

- `apps/guacamole/overlays/dev`
- `apps/guacamole/overlays/staging`
- `apps/guacamole/overlays/prod`

## 5. Verifier le deploiement

```bash
make status
make argocd-ui
```

Applications Argo CD attendues:

- `guacamole-dev`
- `guacamole-staging`
- `guacamole-prod`

## 6. Acceder a Guacamole

Mode Ingress:

- `http://guacamole.local`
- `http://guacamole-staging.local`
- `http://guacamole-prod.local`

Mode port-forward si besoin:

```bash
make app-ui APP_NAME=guacamole
make app-ui APP_NAME=guacamole APP_ENV=staging
make app-ui APP_NAME=guacamole APP_ENV=prod
```

## 7. Connexion initiale

Guacamole initialise sa base PostgreSQL avec le schema officiel.

Identifiants par defaut attendus:

- utilisateur: `guacadmin`
- mot de passe: `guacadmin`

Action recommandee juste apres la premiere connexion:

- changer immediatement le mot de passe administrateur

## 8. Modifier un secret ou un parametre

Exemple:

- modifier `apps/guacamole/overlays/dev/secret-patch.yaml`
- ou `apps/guacamole/overlays/dev/ingress-patch.yaml`

Puis:

```bash
make validate
git add .
git commit -m "feat: update guacamole dev configuration"
git push origin feat/guacamole-bastion
```

Argo CD resynchronisera ensuite l'environnement correspondant.

## 9. Preparation du futur SAML

L'architecture a ete pensee pour faciliter l'ajout de SAML plus tard:

- URLs stables par environnement
- ingress deja present
- PostgreSQL persistant
- utilisation de l'image officielle Guacamole qui embarque l'extension SAML

Plus tard, on ajoutera surtout:

- les variables `SAML_*`
- la configuration du fournisseur d'identite
- potentiellement TLS/HTTPS

## Resume

Le workflow normal du bastion est:

```text
Je decris la config Guacamole dans Git, je pousse, Argo CD synchronise, je verifie via Ingress.
```
