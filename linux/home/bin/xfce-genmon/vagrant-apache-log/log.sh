#!/bin/sh
# Show Apache log of Vagrant machine in XFCE Genmon plugin
#
# Usage:
#
#   $ panel.sh "dirname-of-vagrant-project"

helpers="`dirname $0`/_helpers.sh"
log_file="/tmp/bimlas-xfce-genmon-vagrant-apache-log-$1"

case "$2" in
  update)
    vagrant ssh `"$helpers" "$1" get_machine_id` -- -C 'sudo cat /var/log/apache2/error.log' > "/tmp/bimlas-xfce-genmon-vagrant-apache-log-$1"
    ;;
  *)
    echo "<txt>Log: $1</txt>"
    echo "<img>/usr/share/icons/elementary-xfce/mimes/24/text.png</img>"
    echo "<click>xdg-open "$log_file"</click>"
    echo "<tool><span font_family='monospace'>`cat "$log_file" | tail -5`</span></tool>"
    echo "<txtclick>"$0" "$1" update</txtclick>"
esac
