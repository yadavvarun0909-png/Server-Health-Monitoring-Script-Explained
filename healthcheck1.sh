#!/bin/bash

# -----------------------------
# Server Health Monitoring Script
# -----------------------------

CPU_THRESHOLD=80
MEM_THRESHOLD=75
DISK_THRESHOLD=70

# -------- CPU Usage --------
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/{printf "%.0f", 100 - $8}')

# -------- CPU Cores --------
CPU_CORES=$(nproc)

# -------- Memory Usage (SAFE METHOD) --------
MEM_USAGE=$(free -m | awk '/Mem/{printf "%.0f", ($3/$2) * 100}')

# -------- Disk Usage --------
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# -------- Output --------
echo "CPU Usage: $CPU_USAGE% (Cores: $CPU_CORES)"
echo "Memory Usage: $MEM_USAGE%"
echo "Disk Usage: $DISK_USAGE%"

# -------- Alerts --------
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
  echo "⚠️ ALERT: CPU usage is high!"
fi

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
  echo "⚠️ ALERT: Memory usage is high!"
fi

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  echo "⚠️ ALERT: Disk usage is high!"
fi


# improtant points.
chmod +x server_health.sh
./server_health.sh

