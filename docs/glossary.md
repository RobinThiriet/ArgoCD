# Glossaire

## Argo CD

Outil GitOps pour Kubernetes. Il observe un repository Git et applique les manifests declares.

## GitOps

Approche ou Git devient la source de verite de l'etat desire de l'infrastructure et des applications.

## Kubernetes

Plateforme d'orchestration de conteneurs. Argo CD deploye ses applications dans Kubernetes.

## kind

Outil qui cree un cluster Kubernetes local a l'interieur de conteneurs Docker.

## AppProject

Objet Argo CD qui definit le cadre de securite d'un groupe d'applications:

- repositories autorises;
- destinations autorisees;
- types de ressources autorisees.

## Application

Objet Argo CD qui definit une application a deployer:

- ou est le code;
- quelle branche suivre;
- quel chemin lire;
- ou deployer les ressources.

## Sync

Operation de reconciliation entre l'etat Git et l'etat du cluster.

## Self-heal

Capacite d'Argo CD a remettre le cluster en conformite si une derive est detectee.

## Prune

Suppression automatique des ressources qui n'existent plus dans Git.
