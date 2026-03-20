# SAML Authentication

## Objectif

Cette configuration prepare Apache Guacamole pour une integration SAML conforme a la documentation officielle, sans activer SSO par defaut.

## Choix retenus

- la base PostgreSQL reste active pour stocker utilisateurs, connexions et permissions;
- SAML est present mais desactive tant que l'IdP n'est pas configure;
- la priorite d'extension par defaut est `*, saml` pour conserver l'ecran de login Guacamole et ajouter SAML comme option;
- `SAML_STRICT` reste a `true`, comme recommande en production par la documentation officielle.

## Fichiers concernes

- `apps/guacamole/base/saml-configmap.yaml`
- `apps/guacamole/base/guacamole-deployment.yaml`

## Variables a renseigner

Avant activation, remplacer les placeholders dans `apps/guacamole/base/saml-configmap.yaml`:

- `SAML_ENABLED`: passer de `false` a `true`
- `SAML_IDP_METADATA_URL`: URL du metadata XML de ton fournisseur d'identite
- `SAML_ENTITY_ID`: identifiant du service provider Guacamole
- `SAML_CALLBACK_URL`: URL de retour de Guacamole apres authentification

Variables optionnelles deja preparees:

- `SAML_GROUP_ATTRIBUTE`
- `SAML_DEBUG`
- `SAML_COMPRESS_REQUEST`
- `SAML_COMPRESS_RESPONSE`
- `EXTENSION_PRIORITY`

## Comportement de login

- `EXTENSION_PRIORITY: "*, saml"` conserve le formulaire natif Guacamole et ajoute SAML comme option
- `EXTENSION_PRIORITY: "saml"` force la redirection immediate vers l'IdP

## Verification

Apres modification:

```bash
make validate
kubectl --context kind-argocd-lab -n guacamole rollout restart deployment/guacamole
kubectl --context kind-argocd-lab -n guacamole logs deployment/guacamole
```

Verifier ensuite l'ecran de connexion sur `http://guacamole.local`.
