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
  $CP --verbose "$@" 2>&1                                     \
    | sed -e "s:^$CP.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}

link()
{
  $LN --verbose --symbolic --force --no-dereference "$@" 2>&1 \
    | sed -e "s:^$LN.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}

remember()
{
  header "DON'T FORGET TO:"
  header "* add ~/bin to path"
  header "* run ~/firefox/install_addons.ps1"
  header "* autostart ~/bin/cvim_server"
}
