#!/bin/bash
# Warn if the memory usage is high

# Minimum available memory limit, MB
THRESHOLD=400

available=$(free -m | awk '/^Mem:/{print $7}')

if [[ $available -lt $THRESHOLD ]]; then
    top_usage=$(ps aux --sort=-%mem | head -4 | tail -3 | awk '{print $11 " (" $4 "%)"}')
    notify-send --icon 'dialog-warning' "Memory is running out ($available MB available)
$top_usage"
fi

echo "
  <txt> (RAM guard) </txt>
  <tool>Alerting when RAM is under $THRESHOLD MB</tool>
"
