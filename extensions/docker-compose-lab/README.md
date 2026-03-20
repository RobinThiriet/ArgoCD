# Docker Compose Lab

Ce dossier recupere le contenu utile trouve dans `/root/Guacamole` pour le conserver sur une branche separee de la base GitOps Kubernetes.

Contenu importe:

- `docker-compose.yml` pour le lab Docker Compose;
- `Dockerfile` et `guacamole.sh` pour l'image de test;
- `clean.sh` pour reinitialiser l'environnement Docker;
- `mysql-init/initdb.sql` pour initialiser la base MySQL.

Notes:

- le fichier `MdP` n'a pas ete importe tel quel pour eviter de conserver un fichier d'identifiants en clair;
- les identifiants observes dans ce dossier etaient `guacadmin` / `guacadmin`;
- cette variante utilise MySQL via Docker Compose, alors que la base GitOps principale du repository deploie Guacamole sur Kubernetes avec PostgreSQL.
