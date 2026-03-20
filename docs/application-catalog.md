# Application Catalog

## Application disponible

### `guacamole`

- role: bastion d'acces distant web
- images: `guacamole/guacamole:1.6.0`, `guacamole/guacd:1.6.0`, `postgres:16-alpine`
- service: `svc/guacamole`
- namespace cible: `guacamole`
- acces Ingress: `guacamole.local`

## Application Argo CD

| Nom | Namespace | Path Git |
| --- | --- | --- |
| `guacamole` | `guacamole` | `apps/guacamole` |

## Acces local

Acces Ingress recommande:

- `http://guacamole.local`

Acces port-forward de secours:

```bash
make guacamole-ui
```

Port par defaut:

- `8281`
