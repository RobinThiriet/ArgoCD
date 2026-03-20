# Architecture

## Contexte

Le projet implemente un laboratoire GitOps local avec Argo CD, centre sur un deploiement `prod` unique sur la branche `main`.

## Vue logique

```mermaid
flowchart LR
    Dev[Developpeur] -->|git push| GitHub[Repository GitHub]
    Dev -->|make / kubectl| Cluster[kind cluster]
    GitHub -->|repoURL| ArgoCD[Argo CD]
    ArgoCD -->|sync| Demo[demo-app]
    ArgoCD -->|sync| Hello[hello-app]
```

## Vue de deploiement

```mermaid
flowchart TB
    subgraph Kubernetes["Cluster kind argocd-lab"]
        subgraph NS1["Namespace argocd"]
            Server[argocd-server]
            RepoServer[argocd-repo-server]
            Controller[argocd-application-controller]
        end

        subgraph NS2["Namespace demo-prod"]
            DemoDeployment[Deployment demo-app prod]
            HelloDeployment[Deployment hello-app prod]
        end
    end
```

## Decoupage du repository

- `apps/`: manifests applicatifs avec `base/` et `overlays/prod/`;
- `argocd/`: `AppProject` et `Application`;
- `scripts/`: automatisation locale;
- `docs/`: documentation de reference.
