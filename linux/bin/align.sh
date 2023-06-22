#!/bin/bash
# Align columns to given delimiter
#
# Usage:
# $ cat input.csv | align.sh ';'

delim=${1:-|}
sed "s#\\s*${delim}\\s*#${delim}@#g" | column -s "${delim}" -t | sed "s#@# ${delim} #g"
