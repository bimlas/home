#!/bin/bash
# Rofi mode: move active window to workspace

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  current_desktop=$(wmctrl -d | grep '^\([0-9]\+\) \+\*' | cut -d ' ' -f 1)
  echo -en '\0prompt\x1fMove to workspace\n\0active\x1f'${current_desktop}'\n'

  wmctrl -d | cut --complement -d ' ' -f 2-12 | sed 's/ /\t/' \
  | sed -e 's/.*/&\x00icon\x1fedit-redo/'

# Move to selected item
else
  workspace="${1}"

  # Selected a custom entry, create new workspace
  if [ ${ROFI_RETV} -eq 2 ]; then
    "$(dirname "${0}")/_create_workspace.sh" "${workspace}"
  fi

  # Move active window to workspace and switch to it
  wmctrl -t "${workspace}" -r ":ACTIVE:"
  wmctrl -s "${workspace}"

fi

