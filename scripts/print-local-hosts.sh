#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Ajoute les lignes suivantes dans /etc/hosts :

127.0.0.1 guacamole.local
127.0.0.1 guacamole-staging.local
127.0.0.1 guacamole-prod.local
EOF
