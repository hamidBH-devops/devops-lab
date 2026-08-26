#!/bin/bash

# Seuil critique d'alerte (en %)
THRESHOLD=80

# Extraction de la valeur actuelle du disque racine
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Current disk usage: ${USAGE}%"

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "[WARNING] Disk space critical! Usage is above ${THRESHOLD}%."
else
    echo "[OK] Disk space is within normal operational limits."
fi
