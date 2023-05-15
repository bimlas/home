#!/bin/bash
# Show searchable workpace list, window list (Alt-Tab with filter), SSH hosts and project directories
#
# Define these hotkeys in your window manager:
#
#   Super+Tab
#     /path/to/window-list.sh
#
#   Alt+Tab
#     /bin/bash -c '(sleep 0.2 ; xdotool key Return) & /path/to/window-list.sh'
#
# Modify this line to `~/.config/rofi/config.rasi` to use the same 
# binding to switch between contexts
#
#   kb-mode-next: "Shift+Right,Control+Tab,Super+Tab";

export ROFI_MODES_DIR="$(dirname "${0}")/modes"
export PROJECTS_ROOT='/media/bimlas/src/k8s'

rofi \
  -show workspace \
  -modi workspace:"${ROFI_MODES_DIR}/workspace.sh",window,project:"${ROFI_MODES_DIR}/project.sh",run:"${ROFI_MODES_DIR}/run.sh",ssh \
  -selected-row 1
