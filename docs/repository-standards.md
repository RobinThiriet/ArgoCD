# Repository Standards

## Objectif

Ce document fixe les standards de structure et de contribution du depot afin d'assurer:

- une base lisible pour un debutant;
- une evolution progressive vers une organisation plus complete;
- une qualite documentaire et operationnelle constante.

## Standards de structure

### Racine du depot

La racine doit rester concise et reserver les fichiers aux points d'entree principaux:

- `README.md`
- `Makefile`
- `CONTRIBUTING.md`
- `.github/`
- `apps/`
- `argocd/`
- `docs/`
- `scripts/`

### Applications

Chaque application doit vivre dans son propre dossier sous `apps/`.

Exemple:

```text
apps/
  demo-app/
```

### Objets Argo CD

Les objets Argo CD doivent rester dans `argocd/` pour separer:

- la definition du controle GitOps;
- les manifests applicatifs.

### Documentation

Les guides longs ne doivent pas rester dans le `README` racine. Ils doivent etre places dans `docs/`.

## Standards de branche

Formats recommandes:

- `feat/<topic>`
- `fix/<topic>`
- `docs/<topic>`
- `chore/<topic>`
- `refactor/<topic>`

## Standards de commit

Formats recommandes:

- `feat:`
- `fix:`
- `docs:`
- `chore:`
- `refactor:`
- `test:`

## Standards de Pull Request

Une Pull Request doit:

- rester focalisee sur un sujet;
- decrire clairement le contexte;
- mentionner la validation effectuee;
- signaler tout impact d'architecture;
- mettre a jour la documentation si necessaire.

## Standards de documentation

- le `README` doit fournir la vue d'ensemble du projet;
- `docs/architecture.md` doit refleter l'architecture courante et la cible;
- les nouveaux concepts doivent etre relies au glossaire si utiles;
- les changements structurants doivent etre traces dans `docs/adr/`.

## Standards de validation

La commande minimale de validation locale est:

```bash
make validate
```

La CI GitHub doit executer cette verification sur `push` et `pull_request`.
