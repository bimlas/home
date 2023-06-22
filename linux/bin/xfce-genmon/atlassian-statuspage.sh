#!/bin/bash
# Usage:
#
#  atlassian-statuspage.sh <DOMAIN>
#
# <DOMAIN> is https://<DOMAIN>.statuspage.io/

function _jq()
{
  jq -r "${@}" 2> /dev/null
}

domain=${1}
url="https://${domain}.statuspage.io/api/v2/status.json"
filename="/tmp/xfce-genmon-atlassian-statuspage_${domain}"

curl --silent "${url}" > ${filename}

fetch_error=$(_jq '.status.error_message' "${tokenfilename}")
if [[ "x${fetch_error}" != 'x' ]]; then
  echo "<txt>Error while fetching Statuspage</txt><tool>${fetch_error}</tool>"
  exit 1
fi

name=$(_jq '.page.name' ${filename})
url=$(_jq '.page.url' ${filename})
description=$(_jq '.status.description' ${filename})
indicator=$(_jq '.status.indicator' ${filename})

color='green'
if [[ "x${indicator}" != 'xnone' ]]; then
  color='red'
  if [[ "x$(cat "${filename}_notification")" -ne "x$(date '+%F')" ]]; then
    date '+%F' > "${filename}_notification"
    notify-send --icon 'dialog-warning' "${name}: ${description}"
  fi
else 
  rm "${filename}_notification" 2&> /dev/null
fi 

echo "<txt>${name}: <span foreground=\"${color}\">${description}</span></txt><txtclick>xdg-open '${url}'</txtclick><tool>Click to visit ${url}</tool>"
