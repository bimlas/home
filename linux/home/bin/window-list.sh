#!/bin/bash
# Show searchable window list (Alt-Tab with filter)
#
# Define these hotkeys in your window manager:
#
#   Super+Tab
#     /path/to/window-list.sh
#
#   Alt+Tab
#     /bin/bash -c '(sleep 0.2 ; xdotool key Return) & /path/to/window-list.sh'

rofi -show window -selected-row 1 -show-icons -theme gruvbox-dark-soft
