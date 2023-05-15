#!/bin/bash
# Rofi mode: list workspaces

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  wmctrl -d | cut --complement -d ' ' -f 2-12 | sed 's/ /\t/'

# Open selected item
else
  wmctrl -s "${1}"

fi

