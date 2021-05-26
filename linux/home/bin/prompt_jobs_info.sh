#!/bin/bash
# List jobs in the ZSH, BASH, etc. shell prompt

list_of_jobs=$(grep '^\[')
if [[ -z "$list_of_jobs" ]]; then
  exit 1
fi

RED=$(echo -en "${JOBS_PROMPT_RED:-\e[1;31m}")
GREEN=$(echo -en "${JOBS_PROMPT_GREEN:-\e[1;32m}")
TEXT=$(echo -en "${JOBS_PROMPT_TEXT:-\e[0m}")

formated_list=$(echo "$list_of_jobs" | sed -E 's/^(\[[0-9]+\])\s*([+-])?\s+(\S+)( \([^\)]+\))?\s+([^-\(]+).*/| \1\2 \3 \5/g' | tr -s '\n' ' ')
colorized_list=$(echo "$formated_list" | sed -E -e "s/running /${GREEN}/gi" -e "s/suspended |continued |stopped /${RED}/gi" -e "s/\| /${TEXT}/g")
echo -e "$colorized_list"
