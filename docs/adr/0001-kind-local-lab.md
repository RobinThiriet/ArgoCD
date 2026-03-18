# ADR 0001 - Utiliser kind comme plateforme locale de lab GitOps

## Statut

Accepte

## Contexte

Le projet doit permettre a un debutant de:

- lancer rapidement un environnement de test;
- comprendre la relation entre Docker, Kubernetes et Argo CD;
- supprimer puis recreer l'environnement facilement.

Plusieurs options locales existent:

- lancer seulement un conteneur Argo CD;
- utiliser `kind`;
- utiliser `k3d`;
- utiliser Docker Desktop Kubernetes.

## Decision

Le projet adopte `kind` comme support local principal.

## Justification

- `kind` est simple a installer et deja largement documente;
- il cree un vrai cluster Kubernetes dans Docker;
- il est bien adapte aux environnements ephemeres de demonstration;
- il reduit la complexite par rapport a une distribution plus complete.

## Consequences

### Positives

- environnement reproductible;
- suppression simple avec `kind delete cluster`;
- bonne adequation a un projet pedagogique.

### Negatives

- environnement non representatif d'une production complete;
- pas de load balancer public natif;
- certaines integrations avancees ne sont pas couvertes.

## Alternatives non retenues

### Conteneur Argo CD seul

Non retenu car Argo CD a besoin d'un cluster Kubernetes pour remplir son role.

### Docker Desktop Kubernetes

Non retenu comme choix principal car depend d'un produit et d'un parametrage local plus variables.

### k3d

Bonne alternative, mais `kind` a ete retenu pour rester sur un parcours tres standard et largement adopte.
