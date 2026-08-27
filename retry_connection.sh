#!/bin/bash

TARGET="google.com"
ATTEMPT=1
MAX_ATTEMPTS=5

echo "=== Attempting to connect to $TARGET ==="

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo "Check $ATTEMPT of $MAX_ATTEMPTS..."
    
    if ping -c 1 -W 1 "$TARGET" > /dev/null 2>&1; then
        echo "[SUCCESS] Service is up and reachable!"
        break # Quitte la boucle si le serveur repond
    else
        echo "[WAIT] Host unreachable. Retrying in 2 seconds..."
        sleep 2
    fi
    
    ATTEMPT=$((ATTEMPT + 1))
done

if [ $ATTEMPT -gt $MAX_ATTEMPTS ]; then
    echo "[FAILURE] Could not reach $TARGET after $MAX_ATTEMPTS attempts."
fi
