#!/bin/bash
# Rofi mode: list projects
#
# Depends on `PROJECTS_ROOT`

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  find "${PROJECTS_ROOT}" -mindepth 1 -maxdepth 1 -type d

# Open selected item
else
  title=$(basename "${1}")
  "$(dirname "${0}")/_create_workspace.sh" "${title}"
  xfce4-terminal \
    --title="${title}" \
    --working-directory "${1}" \
    --execute /bin/zsh --interactive --login -c \
    "cd '${1}'; git fetch; git lf; echo; git s; ${SHELL}"

fi

