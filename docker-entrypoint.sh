#!/bin/sh
set -eu

if [ -z "${CLIPIA_API_KEY:-}" ]; then
  echo "CLIPIA_API_KEY is required. Configure it as a Glama secret." >&2
  exit 78
fi

case "${CLIPIA_MCP_URL}" in
  https://*) ;;
  *)
    echo "CLIPIA_MCP_URL must use HTTPS." >&2
    exit 78
    ;;
esac

exec /app/node_modules/.bin/mcp-remote \
  "${CLIPIA_MCP_URL}" \
  --header 'Authorization:Bearer ${CLIPIA_API_KEY}' \
  --silent
