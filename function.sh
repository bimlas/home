#!/bin/bash
# Coloring the error messages.

CP="`which cp`"
LN="`which ln`"
RM="`which rm`"

header()
{
  echo "$@" | sed "s:.*:`printf "\e[0;33m"`&`printf "\e[0m"`:"
}

copy()
{
  $CP --recursive --verbose --force "$@" 2>&1 \
    | sed -e "s:^$CP.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    copy &:"
}

link()
{
  $RM -rf "$2"
  $LN --verbose --symbolic --no-dereference --no-target-directory "$@" 2>&1 \
    | sed -e "s:^$LN.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    link &:"
}
