#!/bin/bash
# Show searchable window list (Alt-Tab with filter), SSH hosts and project directories
# Switch context by Ctlr+Tab
#
# Define these hotkeys in your window manager:
#
#   Super+Tab
#     /path/to/window-list.sh
#
#   Alt+Tab
#     /bin/bash -c '(sleep 0.2 ; xdotool key Return) & /path/to/window-list.sh'

PROJECTS_ROOT='/media/bimlas/src/k8s'

# Create a new named workspace by window manager and make it active
#
# Would be nice to do it by `wmctrl` to be independent from desktop environment
# but I cannot find a way for renaming
function create_workspace()
{
  awesome-client "\
    awful = require('awful'); \
    client = awful.client.focus.history.get()
    tag = awful.tag.add('${1}', {screen = client.screen, layout = awful.layout.layouts[1]}); \
    tag:view_only();"
}

# Show window list
if [ ${?} -eq 0 ] && [ -z ${ROFI_RETV} ]; then
  rofi \
    -show workspace \
    -modi workspace:"${0} workspace",window,project:"${0} project",run:"${0} run",ssh \
    -selected-row 1

# Show modi
elif [ ${ROFI_RETV} -eq 0 ]; then
  modi="${1}"
  shift
  case "${modi}" in

    workspace)
      wmctrl -d | cut --complement -d ' ' -f 2-12 | sed 's/ /\t/'
      ;;

    project)
      find ${PROJECTS_ROOT} -mindepth 1 -maxdepth 1 -type d
      ;;

    run)
      echo "run: cd ${PROJECTS_ROOT}; ${SHELL}"
      echo "sql: cd ${PROJECTS_ROOT}; ${SHELL}"
      echo 'kubernetes: k9s'
      ;;

  esac

# Open selected item
else
  modi="${1}"
  shift
  case "${modi}" in

    workspace)
      wmctrl -s "${1}"
      ;;

    project)
      title=$(basename "${1}")
      create_workspace "${title}"
      xfce4-terminal \
        --title="${title}" \
        --working-directory "${1}" \
        --execute /bin/zsh --interactive --login -c \
        "cd '${1}'; git fetch; git lf; echo; git s; ${SHELL}"
      ;;

    run)
      title=$(sed 's/^\([^:]\+\):.*/\1/' <<< "${1}")
      command=$(sed "s/^${title}://" <<< "${1}")
      create_workspace "${title}"
      xfce4-terminal \
        --title="${title}" \
        --execute /bin/zsh --interactive --login -c \
        "${command}"
      ;;

    esac
fi
