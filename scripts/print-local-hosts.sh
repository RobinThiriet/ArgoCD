#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Ajoute les lignes suivantes dans /etc/hosts :

127.0.0.1 argocd.local
127.0.0.1 guacamole.local
EOF
