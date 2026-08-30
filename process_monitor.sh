#!/bin/bash

# Processus a surveiller
PROCESS_NAME="bash"

echo "=== PROCESS MONITORING ==="
echo "Checking status for process: $PROCESS_NAME"

# Nombre d'instances en cours d'execution
COUNT=$(ps aux | grep -v "grep" | grep -c "$PROCESS_NAME")

if [ "$COUNT" -gt 0 ]; then
    echo "[OK] Process '$PROCESS_NAME' is active ($COUNT instance(s) running)."
else
    echo "[WARNING] Process '$PROCESS_NAME' is NOT running!"
fi
