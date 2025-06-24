#!/bin/bash

# Verificar argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <URL>"
  echo "Ejemplo: $0 http://172.17.0.2"
  exit 1
fi

URL="$1"
WORDLIST="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
EXTENSIONS="php,html,txt"

echo "🔍 Buscando en $URL..."

# Ejecutar feroxbuster y ocultar todo lo innecesario
feroxbuster \
  --url "$URL" \
  -w "$WORDLIST" \
  -x "$EXTENSIONS" \
  -n \
  --quiet \
  --no-state \
  --dont-filter \
  --status-codes 200,403 2>/dev/null
