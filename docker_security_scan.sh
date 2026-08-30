#!/bin/bash

# ==============================================================================
# Script Name : docker_security_scan.sh
# Description : DevSecOps Docker Image Vulnerability Scanner
# Author      : Mido
# ==============================================================================

IMAGE_NAME="my-secure-app:v1"
REPORT_FILE="trivy_scan_report.txt"

echo "=== DEVSECOPS DOCKER IMAGE SECURITY AUDIT ==="
echo "Target Image: $IMAGE_NAME"
echo "Date        : $(date)"
echo "============================================="
echo ""

# Verification de la présence de Trivy
if ! command -v trivy &> /dev/null; then
    echo "[ERROR] Trivy is not installed!"
    exit 1
fi

echo "--- Scanning for HIGH and CRITICAL vulnerabilities ---"
trivy image --severity HIGH,CRITICAL "$IMAGE_NAME" | tee "$REPORT_FILE"

echo ""
echo "============================================="
echo "Scan complete. Report saved to: $REPORT_FILE"
echo "============================================="
