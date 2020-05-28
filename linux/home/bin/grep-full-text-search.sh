#!/bin/bash
# grep-full-text-search.sh: Search for files that contain each word
#
# Usage:
#   grep-full-text-search.sh GREP_OPTIONS PATTERNS FILE...
#
# Examples:
#
#   # Show matches
#   grep-full-text-search.sh --color -H -i "multiple keywords" *.txt
#
#   # List only filenames
#   grep-full-text-search.sh -l "multiple keywords" *.txt
#
# ========================== bimlas.gitlab.io ================================

grep_args=''
while ( echo "$1" | grep '^-' > /dev/null ); do
  grep_args="$grep_args $1"
  shift
done

keywords=$1; shift
file_list=$(printf "%s\n" "$@")

for current in $keywords ; do
  file_list=$(echo "$file_list" | xargs --delimiter="\n" grep --files-with-matches $grep_args "$current")
done

if [ "z$file_list" == "z" ]; then
  exit 1
fi

for current in $keywords; do
  grep_args="$grep_args -e $current"
done

echo "$file_list" | xargs --delimiter="\n" grep $grep_args
