# Runbook

## Commandes d'exploitation

### Afficher l'etat global

```bash
make status
```

### Recuperer les pods Argo CD

```bash
kubectl --context kind-argocd-lab -n argocd get pods
```

### Recuperer l'application Argo CD

```bash
kubectl --context kind-argocd-lab -n argocd get applications.argoproj.io
```

### Ouvrir une application specifique

```bash
make guacamole-ui
make guacamole-ui APP_ENV=staging
make guacamole-ui APP_ENV=prod
```

### Recuperer les ressources Guacamole

```bash
kubectl --context kind-argocd-lab -n guacamole get all
kubectl --context kind-argocd-lab -n guacamole-staging get all
kubectl --context kind-argocd-lab -n guacamole-prod get all
```

### Valider le repository avant commit

```bash
make validate
```

## Depannage

### Le cluster n'existe pas

Symptome:

- les commandes `kubectl --context kind-argocd-lab ...` echouent.

Action:

```bash
make cluster-up
```

### Argo CD ne demarre pas

Verifier:

```bash
kubectl --context kind-argocd-lab -n argocd get pods
kubectl --context kind-argocd-lab -n argocd describe pod <pod-name>
kubectl --context kind-argocd-lab -n argocd logs <pod-name>
```

### `make gitops-bootstrap` echoue

Ca signifie en general:

- qu'il reste des modifications locales non committees;
- que le depot local n'est pas synchronise avec la branche distante suivie.

Verifier:

```bash
git status
git fetch origin feat/guacamole-bastion
git rev-list --left-right --count origin/feat/guacamole-bastion...HEAD
```

### L'application Guacamole n'apparait pas

Verifier:

```bash
kubectl --context kind-argocd-lab -n argocd get application guacamole-dev -o yaml
kubectl --context kind-argocd-lab -n guacamole get all
```

### Le port-forward est deja pris

Changer temporairement de port:

```bash
kubectl --context kind-argocd-lab -n argocd port-forward svc/argocd-server 9090:443
kubectl --context kind-argocd-lab -n guacamole port-forward svc/guacamole 9281:80
kubectl --context kind-argocd-lab -n guacamole-staging port-forward svc/guacamole 9282:80
kubectl --context kind-argocd-lab -n guacamole-prod port-forward svc/guacamole 9283:80
```

## Nettoyage complet

```bash
make destroy
```

Cette commande supprime le cluster local `argocd-lab`.
