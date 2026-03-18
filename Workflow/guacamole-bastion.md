# Workflow Guacamole Bastion

## Objectif

Ce guide decrit le workflow normal pour deployer et exploiter le bastion Guacamole sur cette branche simplifiee.

## Ce que deploie cette branche

- `guacamole`
- `guacd`
- `postgresql`
- un `Secret` Kubernetes avec placeholders documentes
- un `Ingress` local sur `guacamole.local`

## URL locale

- `http://guacamole.local`

## 1. Recreer le cluster local

```bash
make destroy
make cluster-up
make ingress-install
make argocd-install
```

## 2. Ajouter l'entree hosts

Afficher la ligne a ajouter:

```bash
make hosts-print
```

Puis ajouter dans `/etc/hosts`:

```text
127.0.0.1 argocd.local
127.0.0.1 guacamole.local
```

## 3. Comprendre le secret placeholder

Le `Secret` versionne dans Git contient une valeur de type:

```text
CHANGE_ME_GUACAMOLE_DB_PASSWORD
```

Ce n'est pas un vrai secret de production. C'est un placeholder documente pour:

- garder le repo publiable
- montrer la structure GitOps complete
- eviter de pousser un vrai mot de passe

## 4. Bootstrap GitOps

```bash
make gitops-bootstrap
```

## 5. Verifier le deploiement

```bash
make status
```

Application Argo CD attendue:

- `guacamole`

Acces Argo CD:

- `http://argocd.local`

## 6. Acceder a Guacamole

Mode Ingress:

- `http://guacamole.local`

Mode port-forward si besoin:

```bash
make guacamole-ui
```

## 7. Connexion initiale

Identifiants par defaut:

- utilisateur: `guacadmin`
- mot de passe: `guacadmin`

Action recommandee:

- changer immediatement le mot de passe administrateur

## 8. Modifier un parametre

Exemple:

- modifier `apps/guacamole/base/secret.yaml`
- ou `apps/guacamole/base/ingress.yaml`

Puis:

```bash
make validate
git add .
git commit -m "feat: update guacamole configuration"
git push origin feat/guacamole-bastion
```

Argo CD resynchronisera ensuite automatiquement.
