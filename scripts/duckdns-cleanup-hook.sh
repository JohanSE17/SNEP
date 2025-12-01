#!/bin/bash

DOMAIN="svrsej.duckdns.org"
TOKEN="9b3ac1b0-3aa3-4d73-bc81-fd4c89c2b383"

# Limpia el TXT record
curl -s "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&txt=&clear=true"
