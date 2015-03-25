#!/bin/bash
# Coloring the error messages.

CP="`which cp`"
LN="`which ln`"
CWD="`pwd`"

header()
{
  echo "$@" | sed "s:.*:`printf "\e[0;33m"`&`printf "\e[0m"`:"
}

copy()
{
  $CP --verbose "$@" 2>&1                                     \
    | sed -e "s:^$CP.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}

link()
{
  $LN --verbose --symbolic --force "$@" 2>&1                  \
    | sed -e "s:^$LN.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}
