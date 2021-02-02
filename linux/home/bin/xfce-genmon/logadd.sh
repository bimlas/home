#!/bin/sh

echo "<img>/usr/share/icons/elementary-xfce/mimes/24/text.png</img>"
echo "<txt>`cat $HOME/cuccok/download/mylog | tail -1`</txt>"
echo "<tool>`cat $HOME/cuccok/download/mylog | tail -20`</tool>"
echo "<txtclick>xterm -e /bin/bash --login -i -c $HOME/bin/logadd.sh</txtclick>"
