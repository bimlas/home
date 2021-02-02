#!/bin/bash
# Add timestamp to personal log file for time tracking
#
# Use as `logadd.sh genmon` if you want to use as XFCE GenMon widget.

list()
{
  cat $log_file \
  | cut --delimiter ' ' --complement --fields 1,2 \
  | sort --unique
}

add()
{
  message=`
    $0 list \
    | fzf --print-query \
    | tail -1`

  if [ ! -z "$message" ]; then
    echo "`date +"%Y-%m-%d %T"` $message" >> $log_file
  fi
}

genmon()
{
  echo "<img>/usr/share/icons/elementary-xfce/mimes/24/text.png</img>"
  echo "<click>$0 edit</click>"
  echo "<txt>`$0 show | tail -1`</txt>"
  echo "<tool>`$0 show | tail -20`</tool>"
  echo "<txtclick>xterm -e /bin/bash --login -i -c '$0 add'</txtclick>"
}

log_file="$HOME/cuccok/download/mylog"

case "$1" in
  "show") cat "$log_file";;
  "list") list;;
  "add") add;;
  "edit") ${EDITOR:-xdg-open} "$log_file";;
  "genmon") genmon;;
  *)
    echo "Unknown command: $1" >& 2
    exit 1
    ;;
esac
