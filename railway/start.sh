#!/bin/sh
# Railway start wrapper for Vasta: volume ownership + first owner account, then the upstream server as uid "node".
set -e
mkdir -p "$VASTA_DATA"
chown -R node:node "$VASTA_DATA" 2>/dev/null || true
as_node() { setpriv --reuid=node --regid=node --init-groups "$@"; }
if [ -n "$VASTA_ADMIN_PASSWORD" ]; then
  if as_node vasta user list 2>/dev/null | grep -q "^No users yet"; then
    printf '%s\n' "$VASTA_ADMIN_PASSWORD" | as_node vasta user add "$VASTA_ADMIN_USER" --name "$VASTA_ADMIN_NAME" \
      && echo "railway: created owner account \"$VASTA_ADMIN_USER\" from VASTA_ADMIN_PASSWORD"
  else
    echo "railway: accounts already exist, not seeding"
  fi
fi
cd /app
exec setpriv --reuid=node --regid=node --init-groups node --no-warnings packages/server/src/main.ts
