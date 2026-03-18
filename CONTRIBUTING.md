# Contributing

Merci de contribuer a ce projet.

L'objectif du depot est double:

- proposer un socle GitOps local pour Argo CD;
- rester pedagogique et lisible pour un public debutant.

Les contributions doivent donc chercher un bon equilibre entre qualite technique, simplicite et clarte documentaire.

## Workflow recommande

1. creer une branche depuis `main`;
2. faire un changement limite et coherent;
3. valider localement;
4. ouvrir une Pull Request documentee.

## Convention de branches

Les branches recommandees sont:

- `feat/<sujet>` pour une evolution fonctionnelle;
- `fix/<sujet>` pour une correction;
- `docs/<sujet>` pour la documentation;
- `chore/<sujet>` pour la maintenance;
- `refactor/<sujet>` pour une refonte sans changement fonctionnel.

Exemples:

- `feat/add-second-demo-app`
- `docs/improve-architecture-overview`
- `fix/bootstrap-sync-check`

## Convention de commits

Le depot suit une convention proche de Conventional Commits:

- `feat:`
- `fix:`
- `docs:`
- `chore:`
- `refactor:`
- `test:`

Exemples:

```text
feat: add staging overlay structure
docs: improve runbook and contribution guide
fix: harden gitops bootstrap checks
```

## Validation locale

Avant de proposer un changement:

```bash
make validate
```

Si ton changement touche le parcours complet, il est recommande de verifier aussi:

```bash
make status
```

## Attentes sur une Pull Request

Une Pull Request doit:

- expliquer le probleme ou l'objectif;
- decrire la solution proposee;
- indiquer l'impact sur l'architecture ou le workflow;
- mentionner les validations effectuees;
- inclure la mise a jour de la documentation si necessaire.

## Regles de qualite

- garder les scripts shell simples et robustes;
- preferer des exemples concrets et lisibles;
- documenter les choix importants;
- eviter les modifications non necessaires au but de la PR;
- ne pas casser le parcours debutant.

## Documentation

Toute evolution significative doit mettre a jour au minimum l'un des documents suivants:

- [README.md](/root/ArgoCD/README.md)
- [docs/architecture.md](/root/ArgoCD/docs/architecture.md)
- [docs/runbook.md](/root/ArgoCD/docs/runbook.md)
- [docs/repository-standards.md](/root/ArgoCD/docs/repository-standards.md)
