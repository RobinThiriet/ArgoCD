# Workflow Guacamole Bastion

## Objectif

Ce guide decrit le parcours complet pour deployer et exploiter le bastion Guacamole sur cette branche.

## Ce que deploie cette branche

- `guacamole`;
- `guacd`;
- `postgresql`;
- un `Secret` Kubernetes avec placeholders documentes;
- un `Ingress` local sur `guacamole.local`;
- un acces local Argo CD sur `argocd.local`.

## Parcours recommande

### 1. Reinitialiser le lab si besoin

```bash
make destroy
make cluster-up
make ingress-install
make argocd-install
```

### 2. Ajouter les entrees hosts

```bash
make hosts-print
```

Puis ajouter dans `/etc/hosts`:

```text
127.0.0.1 argocd.local
127.0.0.1 guacamole.local
```

### 3. Verifier l'acces Argo CD

- URL: `http://argocd.local`
- mot de passe admin: `make argocd-password`

### 4. Bootstrap GitOps

```bash
make gitops-bootstrap
```

### 5. Verifier le deploiement

```bash
make status
```

Etat attendu:

- application Argo CD `guacamole` presente;
- pods `guacamole`, `guacamole-guacd` et `guacamole-postgresql` en cours d'execution;
- Ingress `guacamole` disponible.

### 6. Acceder a Guacamole

Mode Ingress:

- `http://guacamole.local`

Mode port-forward si besoin:

```bash
make guacamole-ui
```

### 7. Connexion initiale

Identifiants par defaut:

- utilisateur: `guacadmin`;
- mot de passe: `guacadmin`.

Action recommandee:

- changer immediatement le mot de passe administrateur.

### 8. Modifier un parametre en GitOps

Exemples de fichiers:

- `apps/guacamole/base/secret.yaml`;
- `apps/guacamole/base/ingress.yaml`;
- `apps/guacamole/base/guacamole-deployment.yaml`.

Puis:

```bash
make validate
git add .
git commit -m "feat: update guacamole configuration"
git push origin feat/guacamole-bastion
```

Argo CD resynchronisera ensuite automatiquement.
