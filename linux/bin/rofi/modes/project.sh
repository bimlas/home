#!/bin/bash
# Rofi mode: list projects
#
# Depends on `PROJECTS_ROOT`

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  echo -e '\0prompt\x1fproject'

  find "${PROJECTS_ROOT}" -mindepth 1 -maxdepth 1 -type d \
  | sort | sed -e 's/.*/&\x0icon\x1ffolder/'

# Open selected item
else
  title=$(basename "${1}")

  # "$(dirname "${0}")/_create-workspace.sh" "${title}"
  # # Swicth to last (probably newly created) desktop
  # wmctrl -s $(wmctrl -d | tail -1 | cut --delimiter ' ' --fields 1)

  xfce4-terminal \
    --title="${title}" \
    --working-directory "${1}" \
    --execute /bin/zsh --interactive --login -c \
    "cd '${1}'; git fetch; git lf; echo; git s; ${SHELL}"

fi

