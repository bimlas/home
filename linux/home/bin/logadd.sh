#!/bin/sh
# Add timestamp to personal log file for time tracking

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
