# Runbook

## Commandes d'exploitation

### Afficher l'etat global

```bash
make status
```

### Recuperer les pods Ingress

```bash
kubectl --context kind-argocd-lab -n ingress-nginx get pods
```

### Recuperer les pods Argo CD

```bash
kubectl --context kind-argocd-lab -n argocd get pods
```

### Recuperer l'application Argo CD

```bash
kubectl --context kind-argocd-lab -n argocd get applications.argoproj.io
kubectl --context kind-argocd-lab -n argocd get application guacamole -o yaml
```

### Recuperer les ressources Guacamole

```bash
kubectl --context kind-argocd-lab -n guacamole get all
kubectl --context kind-argocd-lab -n guacamole get ingress
kubectl --context kind-argocd-lab -n guacamole get pvc
```

### Acces locaux

- Argo CD: `http://argocd.local`
- Guacamole: `http://guacamole.local`

### Port-forward de secours

```bash
make argocd-ui
make guacamole-ui
```

### Valider le repository

```bash
make validate
```

## Depannage

### `make ingress-install` echoue

Verifier:

```bash
kubectl config get-contexts kind-argocd-lab
```

Si le contexte est absent, recreer le cluster:

```bash
make cluster-up
```

### `argocd.local` ou `guacamole.local` ne repond pas

Verifier:

```bash
make hosts-print
kubectl --context kind-argocd-lab -n ingress-nginx get pods
kubectl --context kind-argocd-lab -n guacamole get ingress
```

Controle attendu dans `/etc/hosts`:

```text
127.0.0.1 argocd.local
127.0.0.1 guacamole.local
```

### `make gitops-bootstrap` echoue

Verifier:

```bash
git status
git fetch origin main
git rev-list --left-right --count origin/main...HEAD
```

### Guacamole ne demarre pas correctement

Verifier:

```bash
kubectl --context kind-argocd-lab -n guacamole get pods
kubectl --context kind-argocd-lab -n guacamole describe pod -l app.kubernetes.io/name=guacamole
kubectl --context kind-argocd-lab -n guacamole logs deployment/guacamole
kubectl --context kind-argocd-lab -n guacamole logs deployment/guacamole-guacd
kubectl --context kind-argocd-lab -n guacamole logs statefulset/guacamole-postgresql
```

## Nettoyage complet

```bash
make destroy
```
