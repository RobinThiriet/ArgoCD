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

### Recuperer les ressources de la demo

```bash
kubectl --context kind-argocd-lab -n demo get all
kubectl --context kind-argocd-lab -n demo-staging get all
kubectl --context kind-argocd-lab -n demo-prod get all
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
- que le depot local n'est pas synchronise avec `origin/main`.

Verifier:

```bash
git status
git fetch origin main
git rev-list --left-right --count origin/main...HEAD
```

### L'application de demo n'apparait pas

Verifier:

```bash
kubectl --context kind-argocd-lab -n argocd get application demo-app-dev -o yaml
kubectl --context kind-argocd-lab -n demo get all
```

### Le port-forward est deja pris

Changer temporairement de port:

```bash
kubectl --context kind-argocd-lab -n argocd port-forward svc/argocd-server 9090:443
kubectl --context kind-argocd-lab -n demo port-forward svc/demo-app 9091:80
kubectl --context kind-argocd-lab -n demo-staging port-forward svc/demo-app 9092:80
kubectl --context kind-argocd-lab -n demo-prod port-forward svc/demo-app 9093:80
```

## Nettoyage complet

```bash
make destroy
```

Cette commande supprime le cluster local `argocd-lab`.
