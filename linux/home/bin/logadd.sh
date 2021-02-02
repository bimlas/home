#!/bin/sh
# Add timestamp to personal log file for time tracking
#
# Use as `/bin/sh -c "GENMON=1 logadd.sh"` if you want to use as XFCE GenMon
# widget.

log_file="$HOME/cuccok/download/mylog"

message=`
  cat $log_file \
  | cut -d ' ' --complement -f 1,2 \
  | sort -u \
  | fzf --print-query \
  | tail -1`

if [ ! -z "$message" ]; then
  echo "`date +"%Y-%m-%d %T"` $message" >> $log_file
fi

if [ ! -z "$GENMON" ]; then
  echo "<img>/usr/share/icons/elementary-xfce/mimes/24/text.png</img>"
  echo "<txt>`cat $log_file | tail -1`</txt>"
  echo "<tool>`cat $log_file | tail -20`</tool>"
  echo "<txtclick>xterm -e /bin/bash --login -i -c $0</txtclick>"
fi
