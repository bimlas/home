#!/bin/bash
# randomly_pause_player: Randomly pause music for children's play
#
# Usage:
#   watch randomly_pause_player
#
# Note:
#   YouTube works only in Firefox

if (( $RANDOM > 25000 )); then
  playerctl --all-players play-pause
  # sleep `expr $RANDOM / 1000 / 5`
  sleep 2
  playerctl --all-players play-pause
fi
