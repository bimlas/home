#!/bin/bash
# Warn if the memory usage is high

#Minimum available memory limit, MB
THRESHOLD=400

#Check time interval, sec
INTERVAL=5

echo "The system will warn you when the available memory is less then $THRESHOLD MB"

while :
do
    available=$(free -m | awk '/^Mem:/{print $7}')

    if [[ $available -lt $THRESHOLD ]]; then
        top_usage=$(ps aux --sort=-%mem | head -4 | tail -3 | awk '{print $11 " (" $4 "%)"}')
        kdialog --passivepopup "Memory is running out ($available MB available)\n$top_usage"
    fi

    sleep $INTERVAL
done
