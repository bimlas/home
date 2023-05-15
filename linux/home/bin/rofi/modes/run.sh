#!/bin/bash
# Rofi mode: run item of a predefined list

# List items
if [ ${ROFI_RETV} -eq 0 ]; then
  echo "run: cd ${PROJECTS_ROOT}; ${SHELL}"
  echo "sql: cd ${PROJECTS_ROOT}; ${SHELL}"
  echo 'kubernetes: k9s'

# Open selected item
else
  title=$(sed 's/^\([^:]\+\):.*/\1/' <<< "${1}")
  command=$(sed "s/^${title}://" <<< "${1}")
  "$(dirname "${0}")/_create_workspace.sh" "${title}"
  xfce4-terminal \
    --title="${title}" \
    --execute /bin/zsh --interactive --login -c \
    "${command}"

fi

