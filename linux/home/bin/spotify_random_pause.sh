#!/bin/bash
# spotify_random_pause: Randomly pause music for children's play
#
# Usage:
#  watch spotify_random_pause

if (( $RANDOM > 25000 )); then
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
  sleep 2
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
fi
