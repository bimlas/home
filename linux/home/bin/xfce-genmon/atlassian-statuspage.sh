#!/bin/bash
# Usage:
#
#  atlassian-statuspage.sh <DOMAIN>
#
# <DOMAIN> is https://<DOMAIN>.statuspage.io/

domain=${1}
url="https://${domain}.statuspage.io/api/v2/status.json"
filename="/tmp/xfce-genmon-atlassian-statuspage_${domain}"

curl --silent "${url}" > ${filename}

name=$(jq '.page.name' ${filename} | sed 's/"//g')
url=$(jq '.page.url' ${filename} | sed 's/"//g')
description=$(jq '.status.description' ${filename} | sed 's/"//g')
indicator=$(jq '.status.indicator' ${filename} | sed 's/"//g')

color='green'
if [[ "x${indicator}" -ne 'xnone' ]]; then
  color='red'
  if [[ "x$(cat "${filename}_notification")" -ne "x$(date '+%F')" ]]; then
    date '+%F' > "${filename}_notification"
    notify-send --icon 'dialog-warning' "${name}: ${description}"
  fi
else 
  rm "${filename}_notification" 2&> /dev/null
fi 

echo "<txt>${name}: <span foreground=\"${color}\">${description}</span></txt><txtclick>xdg-open '${url}'</txtclick><tool>Click to visit ${url}</tool>"
