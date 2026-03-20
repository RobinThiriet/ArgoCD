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

### Recuperer les applications Argo CD

```bash
kubectl --context kind-argocd-lab -n argocd get applications.argoproj.io
```

### Ouvrir une application specifique

```bash
make demo-ui
make app-ui APP_NAME=hello-app
```

### Recuperer les ressources applicatives

```bash
kubectl --context kind-argocd-lab -n demo-prod get all
```

### Valider le repository avant commit

```bash
make validate
```

## Depannage

### `make gitops-bootstrap` echoue

Verifier:

```bash
git status
git fetch origin main
git rev-list --left-right --count origin/main...HEAD
```

### L'application de demo n'apparait pas

Verifier:

```bash
kubectl --context kind-argocd-lab -n argocd get application demo-app-prod -o yaml
kubectl --context kind-argocd-lab -n argocd get application hello-app-prod -o yaml
kubectl --context kind-argocd-lab -n demo-prod get all
```

### Le port-forward est deja pris

```bash
kubectl --context kind-argocd-lab -n argocd port-forward svc/argocd-server 9090:443
kubectl --context kind-argocd-lab -n demo-prod port-forward svc/demo-app 9093:80
kubectl --context kind-argocd-lab -n demo-prod port-forward svc/hello-app 9193:80
```
