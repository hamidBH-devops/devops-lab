#!/bin/bash

# ==============================================================================
# Script Name : network_audit.sh
# Description : Network connectivity & HTTP status diagnostic tool
# Author      : Mido
# ==============================================================================

TARGET_DOMAIN="github.com"
TARGET_URL="https://github.com"

echo "=== NETWORK DIAGNOSTIC REPORT FOR $TARGET_DOMAIN ==="
echo "Date: $(date)"
echo ""

# 1. Verification DNS
echo "--- [1] DNS Resolution Check ---"
IP=$(dig +short "$TARGET_DOMAIN" | tail -n1)

if [ -n "$IP" ]; then
    echo "[OK] Resolved $TARGET_DOMAIN to IP: $IP"
else
    echo "[FAIL] Could not resolve DNS for $TARGET_DOMAIN"
fi
echo ""

# 2. Verification du statut HTTP
echo "--- [2] HTTP Endpoint Response Check ---"
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$TARGET_URL")

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "[OK] Endpoint $TARGET_URL responded with HTTP status $HTTP_STATUS"
else
    echo "[WARNING] Endpoint $TARGET_URL responded with status $HTTP_STATUS"
fi
