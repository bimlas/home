#!/bin/bash
source function.sh

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
  ".vim/"          \
  ".ctags"         \
  ".gitconfig"     \
  ".gvimrc"        \
  ".pentadactylrc" \
  ".vimperatorrc"  \
  ".vimrc"         \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/AppData/Roaming/Mozilla/Firefox/Profiles/*/

copy             \
  _thunderbird/* \
  $HOME/AppData/Roaming/Thunderbird/Profiles/*/

header "  CREATING DIRECTORIES"

mkdir -p "$HOME/.vim/.swap/"
mkdir -p "$HOME/.vim/.undo/"
mkdir -p "$HOME/.vim/bundle/"

header "DON'T FORGET TO ADD ~/bin TO PATH"
