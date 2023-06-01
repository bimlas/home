#!/bin/bash
# Rofi mode: list workspaces

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  current_desktop=$(wmctrl -d | grep '^\([0-9]\+\) \+\*' | cut -d ' ' -f 1)
  echo -en '\x00prompt\x1fWorkspace\n\x00active\x1f'${current_desktop}'\n'

  wmctrl -d | cut --complement -d ' ' -f 2-12 \
  | sed -e 's/.*/&\x0icon\x1fgo-next/'

# Open selected item
else
  wmctrl -s "${1}"

fi

