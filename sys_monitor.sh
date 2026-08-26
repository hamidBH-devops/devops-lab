#!/bin/bash

# Definition des variables
DATE=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="system_health.log"

echo "=== System Report generated on $DATE ===" > $LOG_FILE
echo "User: $USER" >> $LOG_FILE
echo "Hostname: $HOSTNAME" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "--- Uptime ---" >> $LOG_FILE
uptime >> $LOG_FILE
echo "" >> $LOG_FILE

echo "--- Disk Usage ---" >> $LOG_FILE
df -h / >> $LOG_FILE

echo "Report generated successfully in $LOG_FILE"

