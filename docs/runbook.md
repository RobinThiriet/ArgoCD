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

### Recuperer les ressources Guacamole

```bash
kubectl --context kind-argocd-lab -n guacamole get all
```

### Ouvrir Guacamole

```bash
make guacamole-ui
```

### Valider le repository

```bash
make validate
```

## Nettoyage complet

```bash
make destroy
```
