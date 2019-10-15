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
        kdialog --passivepopup "Memory is running out ($available MB available)"
    fi

    sleep $INTERVAL
done
