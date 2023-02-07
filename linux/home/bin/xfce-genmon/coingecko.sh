#!/bin/bash
# Usage:
#
#  coingecko.sh <WARNING_LEVEL> <COINGECKO_TOKEN_IDs...>
#
# Warning level indicates the thresholds of price change which you would like
# to receive notifications.

warninglevel=$1
shift
tokens=${@}
filename='/tmp/xfce-genmon-coingecko'

curl --silent "https://api.coingecko.com/api/v3/simple/price?ids=${tokens// /%2C}&vs_currencies=usd&include_24hr_change=true" > ${filename}

contents=''
for token in ${tokens}; do

  tokenfilename="${filename}_${token}"
  if [[ ! -f "${tokenfilename}" ]]; then
    curl --silent "https://api.coingecko.com/api/v3/coins/${token}?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false" > ${tokenfilename}
  fi
  symbol=$(jq '.symbol' ${tokenfilename} | tr '[:lower:]' '[:upper:]' | sed 's/"//g')

  price=$(jq ".\"${token}\".usd" ${filename})
  change=$(jq ".\"${token}\".usd_24h_change | . * 100.0 + 0.5 | floor / 100.0" ${filename})

  color='green'
  if [[ $(echo "${change} < 0" | bc) -eq 1 ]]; then
    color='red'
  fi

  # Warn on huge change, show a popup only once
  changecolor=${color}
  echo $warninglevel
  if [[ $(echo "${change#-} > ${warninglevel}" | bc) -eq 1 ]]; then
    if [[ "x$(cat "${tokenfilename}_notification")" -ne "x$(date '+%F')" ]]; then
      date '+%F' > "${tokenfilename}_notification"
      notify-send --icon 'dialog-warning' "Huge price change on ${symbol}"
    fi
    changecolor='yellow'
    change="<b>${change}</b>"
  else 
    rm "${tokenfilename}_notification" 2&> /dev/null
  fi 

  contents="$contents <b>${symbol}</b>: <span foreground=\"${color}\">${price}</span> <span foreground=\"${changecolor}\">(${change}%)</span>"
done

echo "<tool>Go to CoinGecko</tool><txtclick>xdg-open 'https://www.coingecko.com/'</txtclick><txt>${contents}</txt>"
