#!/bin/bash
# Usage:
#
#  coingecko.sh <WARNING_LEVEL> <COINGECKO_TOKEN_IDs...>
#
# Warning level indicates the thresholds of price change which you would like
# to receive notifications.

warninglevel=$1
shift
tokens="${@}"
trending_tokens=$(curl --silent 'https://api.coingecko.com/api/v3/search/trending' | jq '.coins [].item .id' | sed 's/"//g' | tr '\n' ' ')
filename='/tmp/xfce-genmon-coingecko'

function get_prices()
{
  contents=''
  for token in ${@}; do
    tokenfilename="${filename}_${token}"
    if [[ ! -f "${tokenfilename}" ]]; then
      curl --silent "https://api.coingecko.com/api/v3/coins/${token}?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false" > "${tokenfilename}"
    fi
    fetch_error=$(jq '.status.error_message' "${tokenfilename}" | sed 's/"//g')
    if [[ "x${fetch_error}" != 'xnull' ]]; then
      rm "${tokenfilename}"
      continue
    fi

    symbol=$(jq '.symbol' ${tokenfilename} | tr '[:lower:]' '[:upper:]' | sed 's/"//g')
    id=$(jq '.id' ${tokenfilename} | sed 's/"//g')
    price=$(jq ".\"${token}\".usd" ${filename})
    change=$(jq ".\"${token}\".usd_24h_change | . * 100.0 + 0.5 | floor / 100.0" ${filename})

    color='green'
    if [[ $(echo "${change} < 0" | bc) -eq 1 ]]; then
      color='red'
    fi

    # Warn on huge change, show a popup only once
    changecolor=${color}
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

    if [[ -n "${TOOLTIP:+is_set}" ]]; then
      contents="$contents\n${symbol} ${id} \$${price} (${change}%)"
    else
      contents="$contents ${symbol}: <span foreground=\"${color}\">\$${price}</span> <span foreground=\"${changecolor}\">(${change}%)</span>"
    fi
  done
  echo -e "${contents}"
}

curl --silent "https://api.coingecko.com/api/v3/simple/price?ids=${trending_tokens// /%2C}${tokens// /%2C}&vs_currencies=usd&include_24hr_change=true" > "${filename}"

fetch_error=$(jq '.status.error_message' "${filename}" | sed 's/"//g')
if [[ "x${fetch_error}" != 'xnull' ]]; then
  echo "<txt>Error while fetching CoinGecko</txt><tool>${fetch_error}</tool>"
else
  echo -e "<txt>$(get_prices ${tokens})</txt><txtclick>xdg-open 'https://www.coingecko.com/'</txtclick><tool>Click to visit CoinGecko\n\nTrending tokens:\n\n<span font-family=\"monospace\" allow-breaks=\"false\">$(TOOLTIP=1 get_prices ${trending_tokens} | column -t)</span></tool>"
fi
