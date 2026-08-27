#!/bin/bash

# ==============================================================================
# Script Name : devops_health_check.sh
# Description : System diagnostic tool (Sprint 1 Capstone Project)
# Author      : Mido
# ==============================================================================

# Fichier de sortie pour les logs
LOG_FILE="sprint1_report.log"

# Fonction principale d'audit
generate_report() {
    echo "=================================================="
    echo "       DEVOPS SYSTEM HEALTH CHECK REPORT          "
    echo "=================================================="
    echo "Date & Time : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Hostname    : $HOSTNAME"
    echo "User        : $USER"
    echo "=================================================="
    echo ""

    # 1. Verification de l'espace disque
    echo "--- [1/2] Disk Space Check ---"
    THRESHOLD=80
    USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Current disk usage: ${USAGE}%"

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "Status: [WARNING] Disk usage exceeds ${THRESHOLD}%!"
    else
        echo "Status: [OK] Disk space within limits."
    fi
    echo ""

    # 2. Verification de la connectivité réseau
    echo "--- [2/2] Network Reachability Check ---"
    TARGETS=("google.com" "8.8.8.8" "127.0.0.1")

    for TARGET in "${TARGETS[@]}"; do
        if ping -c 1 -W 1 "$TARGET" > /dev/null 2>&1; then
            echo "Host: $TARGET -> [ONLINE]"
        else
            echo "Host: $TARGET -> [OFFLINE]"
        fi
    done

    echo ""
    echo "=================================================="
    echo "             END OF DIAGNOSTIC REPORT             "
    echo "=================================================="
    echo ""
}

# Execution de la fonction + Envoi simultané vers l'écran ET le fichier log
generate_report | tee "$LOG_FILE"
