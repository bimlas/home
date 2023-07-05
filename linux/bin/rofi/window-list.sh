#!/bin/bash
# Show searchable workpace list, window list (Alt-Tab with filter), SSH hosts and project directories
#
# Define these hotkeys in your window manager:
#
#   Super+Tab
#     /path/to/window-list.sh
#
# Modify this line to `~/.config/rofi/config.rasi` to use the same 
# binding to switch between contexts
#
#   kb-mode-next: "Shift+Right,Control+Tab,Super+Tab";

export ROFI_MODES_DIR="$(dirname "${0}")/modes"
export PROJECTS_ROOT='/media/bimlas/data/magpie/'

rofi \
  -show window \
  -modi window,project:"${ROFI_MODES_DIR}/project.sh",ssh \
  -window-command "$(dirname "${0}")/modes/_move-to-common-workspace.sh {window}"
