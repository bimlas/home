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

# Create real symlink instead of copies - needs admin rights.
export MSYS=winsymlinks:nativestrict
# Poor way to determine if the user is admin (user cannot run `at` command).
at > /dev/null && export is_win_admin=1 || export is_win_admin=0

link()
{
  if [ $MSYSTEM ] && [ $is_win_admin -eq 0 ]; then
    printf "\e[0;33m    using copy instead of symlink: needs admin rights\e[0m\n"
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
  header "* add ~/bin to path"
  header "* add ~/.gitconfig_files/custom_commands' to path"
  header "* run ~/firefox/install_addons.ps1"
  header "* autostart autohotkey scripts"
}
