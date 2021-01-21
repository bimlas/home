#!/bin/sh
# Show Apache log of Vagrant machine in XFCE Genmon plugin
#
# Usage:
#
#   Command:  vagrant-apache-log.sh "dirname-of-vagrant-project"
#   Interval: 3
#
#   * Click on the text to get the latest log
#   * Click on the icon to open the log in your editor

log_file="/tmp/bimlas-xfce-genmon-vagrant-apache-log-$1"

case "$2" in
  update)
    machine_id=`vagrant global-status | grep "/$1\\s*$" | awk '{print $1}'`
    vagrant ssh "$machine_id" -- -C 'sudo cat /var/log/apache2/error.log' > "$log_file"
    ;;
  *)
    echo "<txt>Log: $1</txt>"
    echo "<img>/usr/share/icons/elementary-xfce/mimes/24/text.png</img>"
    echo "<click>xdg-open "$log_file"</click>"
    echo "<tool><span font_family='monospace'>`cat "$log_file" | tail -5`</span></tool>"
    echo "<txtclick>"$0" "$1" update</txtclick>"
esac
