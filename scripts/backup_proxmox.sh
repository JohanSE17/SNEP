#!/bin/bash
BACKUP_DIR="/var/lib/vz/dump"
DATE=$(date +%Y%m%d)
vzdump --all --mode snapshot --compress gzip --storage local --quiet
find $BACKUP_DIR -type f -mtime +30 -exec rm {} \;
chmod +x /root/backup_proxmox.sh
