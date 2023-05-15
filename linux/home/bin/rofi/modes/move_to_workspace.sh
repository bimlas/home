#!/bin/bash
# Rofi mode: move active window to workspace

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  wmctrl -d | cut --complement -d ' ' -f 2-12 | sed 's/ /\t/'

# Move to selected item
else
  # TODO: Creates workspace, but not moving window
  # Selected a custom entry, create new workspace
  if [ ${ROFI_RETV} -eq 2 ]; then
    "$(dirname "${0}")/_create_workspace.sh" "${1}"
  fi

  wmctrl -t "${1}" -r ":ACTIVE:"
  wmctrl -s "${1}"

fi

