#!/bin/bash
# Coloring the error messages.

CP="`which cp`"
LN="`which ln`"

header()
{
  echo "$@" | sed "s:.*:`printf "\e[0;33m"`&`printf "\e[0m"`:"
}

copy()
{
  $CP --recursive --verbose --force "$@" 2>&1 \
    | sed -e "s:^$CP.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}

link()
{
  if [[ -v 'is_win_admin' ]] && [[ $is_win_admin -eq 0 ]]; then
    copy $@
  else
    $LN --verbose --symbolic --force --no-dereference "$@" 2>&1 \
      | sed -e "s:^$LN.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
      | sed "s:.*:    &:"
  fi
}
