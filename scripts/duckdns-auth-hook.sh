#!/bin/bash
# Colocas el dominio
DOMAIN="duckdns.org"
TOKEN="9byguh...hjvf5h..."
TXT_VALUE="$CERTBOT_VALIDATION"

# Actualiza el TXT record en DuckDNS
curl -s "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&txt=$TXT_VALUE&clear=true"

# Espera para que el cambio se propague
sleep 10
