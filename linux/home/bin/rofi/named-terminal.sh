#!/bin/bash
# Create named terminal to easily find in window list
#
# Define these hotkeys in your window manager:
#
#   Super+Enter
#     /path/to/named-terminal.sh

title="$(rofi -dmenu -p 'Title of terminal' -theme-str 'listview { enabled: false; }')"
if [ "x${title}" != "x" ]; then
  x-terminal-emulator -T "${title}"
fi
