#!/bin/bash

# ==============================================================================
# Script Name : sprint2_audit_tool.sh
# Description : Integrated Linux Administration & Network Audit Tool
# Author      : Mido
# ==============================================================================

LOG_FILE="sprint2_report.log"

run_sprint2_audit() {
    echo "=================================================="
    echo "         SPRINT 2 INTEGRATED SYSTEM AUDIT         "
    echo "=================================================="
    echo "Date     : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Hostname : $HOSTNAME"
    echo "User     : $USER"
    echo "=================================================="
    echo ""

    # 1. Verification Utilisateur & Permissions
    echo "--- [1/3] Security & User Check ---"
    if id "developer" &>/dev/null; then
        echo "[OK] User 'developer' exists."
    else
        echo "[WARNING] User 'developer' does NOT exist."
    fi

    if [ -d "$HOME/devops-lab/shared_app" ]; then
        PERMS=$(stat -c "%a" "$HOME/devops-lab/shared_app")
        echo "[OK] Directory 'shared_app' exists with permissions: $PERMS"
    else
        echo "[WARNING] Directory 'shared_app' does not exist."
    fi
    echo ""

    # 2. Diagnostic Réseau
    echo "--- [2/3] Network & Endpoint Check ---"
    TARGET="github.com"
    IP=$(dig +short "$TARGET" | tail -n1)
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" "https://$TARGET")

    if [ -n "$IP" ]; then
        echo "[OK] DNS Resolution: $TARGET -> $IP"
    else
        echo "[FAIL] DNS Resolution failed for $TARGET"
    fi

    if [ "$HTTP_CODE" -eq 200 ]; then
        echo "[OK] HTTP Endpoint: https://$TARGET returned $HTTP_CODE"
    else
        echo "[WARNING] HTTP Endpoint returned status $HTTP_CODE"
    fi
    echo ""

    # 3. Surveillance des Processus
    echo "--- [3/3] Active Process Check ---"
    PROC_NAME="bash"
    PROC_COUNT=$(ps aux | grep -v "grep" | grep -c "$PROC_NAME")
    echo "[OK] Active instances of '$PROC_NAME': $PROC_COUNT"

    echo ""
    echo "=================================================="
    echo "               END OF SPRINT 2 AUDIT              "
    echo "=================================================="
}

# Affichage terminal + enregistrement simultané dans le fichier log
run_sprint2_audit | tee "$LOG_FILE"
