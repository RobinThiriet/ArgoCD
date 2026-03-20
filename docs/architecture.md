# Architecture

## Contexte

Le projet implemente un bastion Guacamole pilote en GitOps avec un seul environnement de travail.

## Vue logique

```mermaid
flowchart LR
    Dev[Developpeur] -->|git push| GitHub[Repository GitHub]
    Dev -->|make / kubectl| Cluster[kind cluster]
    GitHub -->|repoURL| ArgoCD[Argo CD]
    ArgoCD -->|sync| Guacamole[Guacamole]
```

## Vue de deploiement

```mermaid
flowchart TB
    subgraph Kubernetes["Cluster kind argocd-lab"]
        subgraph Argo["Namespace argocd"]
            Server[argocd-server]
            Repo[argocd-repo-server]
            Controller[argocd-application-controller]
        end

        subgraph Bastion["Namespace guacamole"]
            Ingress[Ingress guacamole.local]
            Web[Deployment guacamole]
            Guacd[Deployment guacd]
            Db[StatefulSet postgresql]
            Secret[Secret guacamole-secrets]
            Pvc[PersistentVolumeClaim]
        end
    end

    Repo --> Web
    Repo --> Guacd
    Repo --> Db
    Ingress --> Web
    Web --> Guacd
    Web --> Db
    Db --> Pvc
    Web --> Secret
    Db --> Secret
```

## Decoupage du repository

- `apps/guacamole/` contient les manifests Kubernetes
- `argocd/` contient les objets Argo CD
- `scripts/` automatise les operations locales
- `docs/` contient la documentation projet

## Choix structurants

- `kind` pour un cluster local reproductible
- Argo CD `v3.3.4`
- PostgreSQL persistant
- Ingress local stable sur `guacamole.local`

## Limites actuelles

- pas encore de TLS
- pas encore de SAML
- les secrets restent des placeholders de lab
