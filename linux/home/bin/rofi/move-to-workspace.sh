#!/bin/bash
# Move active client to workspace

export ROFI_MODES_DIR="$(dirname "${0}")/modes"

rofi \
  -show move_to_workspace \
  -modi move_to_workspace:"${ROFI_MODES_DIR}/move-to-workspace.sh"
  # TODO: -selected-row 1
