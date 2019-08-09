#!/bin/bash
# conky-media-list: List mounted devices
# https://forums.bunsenlabs.org/viewtopic.php?pid=74021#p74021

df -h | grep '^/dev/' | grep -v '\s/snap/' | while read DEVICE SIZE USED FREE PERCENT MOUNT
do
  echo "$MOUNT\${alignr} $SIZE - $USED = $FREE \${fs_bar 8,60 $MOUNT}"
done
