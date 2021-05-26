#!/bin/bash
# List jobs in the ZSH, BASH, etc. shell prompt

list_of_jobs=$(grep '^\[')
if [[ -z "$list_of_jobs" ]]; then
  exit 1
fi

formated_list=$(echo "$list_of_jobs" | sed -E 's/^(\[[0-9]+\])\s*([+-])?\s+(\S+)( \([^\)]+\))?\s+([^-]+).*/\1\2 \3 \5 |/g' | tr -s '\n' ' ')
colorized_list=$(echo "$formated_list" | sed -E -e "s/running /$2/gi" -e "s/suspended |continued |stopped /$3/gi" -e "s/ \|/$1/g")
echo "$1$colorized_list"
