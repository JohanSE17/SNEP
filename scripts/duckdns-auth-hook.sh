#!/bin/bash

DOMAIN="svrsej.duckdns.org"
TOKEN="9b3ac1b0-3aa3-4d73-bc81-fd4c89c2b383"
TXT_VALUE="$CERTBOT_VALIDATION"

# Actualiza el TXT record en DuckDNS
curl -s "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&txt=$TXT_VALUE&clear=true"

# Espera para que el cambio se propague
sleep 10
