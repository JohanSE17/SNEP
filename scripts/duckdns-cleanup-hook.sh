#!/bin/bash
# Tu dominio
DOMAIN="duckdns.org"
TOKEN="dfpko...sioo..qwpon"

# Limpia el TXT record
curl -s "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&txt=&clear=true"
