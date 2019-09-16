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
  $CP --verbose --force "$@" 2>&1                                     \
    | sed -e "s:^$CP.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
    | sed "s:.*:    &:"
}

link()
{
  if [[ $is_win_admin -eq 0 ]]; then
    copy $@
  else
    $LN --verbose --symbolic --force --no-dereference "$@" 2>&1 \
      | sed -e "s:^$LN.*:`printf "\e[0;31m"`&`printf "\e[0m"`:" \
      | sed "s:.*:    &:"
  fi
}

remember()
{
  header "DON'T FORGET TO:"
  header "* run ~/firefox/install_addons.ps1"
  header "ON LINUX (KDE):"
  header "* enable search indexing on data partitions"
  header "* install 'dolphin-plugins' for Git integration"
  header "* install 'plasma-applet-redshift-control' for RedShift applet"
  header "* install Krohnkite KWin script for tiling and see your notes about setting it up"
  header "* install United KDE Plasma theme in Plasma settings if not works"
  header "ON WINDOWS:"
  header "* add ~/bin to path"
  header "* add ~/.gitconfig_files/custom_commands to path"
  header "* add ~/.gitconfig_files/custom_commands/diff-so-fancy to path"
  header "* autostart autohotkey scripts"
  header "* set LC_ALL=hu_HU.UTF-8 to avoid weird chars in Git log"
  header "* set EDITOR to use for Git"
}
