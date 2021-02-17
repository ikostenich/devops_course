#!/bin/bash
RUNNING_PROCESSES_NUMBER=$(ps -A | awk 'END {print NR}')
CPU_LOAD=$(top -b -n 1 | grep %Cpu | awk '{print $2}')
RAM_FREE=$(top -b -n 1 | grep 'MiB Mem' | awk '{print $8}')

echo "$RUNNING_PROCESSES_NUMBER $CPU_LOAD $RAM_FREE"
