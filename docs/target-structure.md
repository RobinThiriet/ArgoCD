# Target Structure

## Objectif

Le depot courant est simplifie autour de `prod`. Ce document decrit une cible de croissance raisonnable si plusieurs environnements doivent revenir plus tard.

## Structure actuelle

```text
.
|-- apps
|   |-- demo-app
|   |   |-- base
|   |   `-- overlays
|   |       `-- prod
|   `-- hello-app
|       |-- base
|       `-- overlays
|           `-- prod
|-- argocd
|   |-- projects
|   |   `-- demo-project.yaml
|   `-- applications
|       |-- demo-app-prod.yaml
|       `-- hello-app-prod.yaml
`-- docs
```

## Chemin de migration recommande

1. conserver un fonctionnement simple sur `prod`;
2. ajouter des applications si besoin;
3. reintroduire d'autres environnements seulement si un vrai besoin apparait;
4. envisager `ApplicationSet` si le nombre de cibles augmente.
