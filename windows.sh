#!/bin/bash

CWD="`dirname $0`"
source "$CWD/function.sh"

header "DEPLOYING ./windows"
cd "$CWD/windows"

header "  COPY"

copy --recursive \
  "AppData"      \
  "Documents"    \
  "$HOME"

header "DEPLOYING ./linux/home"
cd "$CWD/linux/home"

header "  COPY"

copy --recursive   \
  "bin/"           \
  ".git_template/" \
  ".pentadactyl/"  \
  ".vim/"          \
  ".ctags"         \
  ".gitconfig"     \
  ".gvimrc"        \
  ".pentadactylrc" \
  ".spacemacs"     \
  ".vimrc"         \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/AppData/Roaming/Mozilla/Firefox/Profiles/*/

copy             \
  _thunderbird/* \
  $HOME/AppData/Roaming/Thunderbird/Profiles/*/

header "DON'T FORGET TO ADD ~/bin TO PATH"
