#!/bin/bash

# Get the dirname of the script.
# http://stackoverflow.com/a/246128
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
CWD="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source "$CWD/function.sh"

header "DEPLOYING ./linux/home"
cd "$CWD/linux/home"

header "  COPY"

copy --recursive   \
  ".aptitude/"     \
  ".config/"       \
  ".local/"        \
  ".vimrc_minimal" \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/.mozilla/firefox/*.default/

copy             \
  _thunderbird/* \
  $HOME/.thunderbird/*.default/

copy              \
  _intellijidea/* \
  $HOME/.IntelliJIdea*/

header "  SYMLINK"

link "$CWD/linux/home/bin/"              "$HOME/bin"
link "$CWD/linux/home/.gitconfig_files/" "$HOME/.gitconfig_files"
link "$CWD/linux/home/.bashrc"           "$HOME/.bashrc"
link "$CWD/linux/home/.boostnoterc"      "$HOME/.boostnoterc"
link "$CWD/linux/home/.conkyrc"          "$HOME/.conkyrc"
link "$CWD/linux/home/.gitconfig"        "$HOME/.gitconfig"
link "$CWD/linux/home/.gemrc"            "$HOME/.gemrc"
link "$CWD/linux/home/.gvimrc"           "$HOME/.gvimrc"
link "$CWD/linux/home/.inputrc"          "$HOME/.inputrc"
link "$CWD/linux/home/.profile"          "$HOME/.profile"
link "$CWD/linux/home/.sh_commons"       "$HOME/.sh_commons"
link "$CWD/linux/home/.vimrc"            "$HOME/.vimrc"
link "$CWD/linux/home/.vimrc_viewer"     "$HOME/.vimrc_viewer"
link "$CWD/linux/home/.xbindkeysrc"      "$HOME/.xbindkeysrc"
link "$CWD/linux/home/.Xresources"       "$HOME/.Xresources"
link "$CWD/linux/home/.xsessionrc"       "$HOME/.xsessionrc"
link "$CWD/linux/home/.zshrc"            "$HOME/.zshrc"
mkdir -p "$HOME/.config/nvim/"
link "$CWD/linux/home/.config/ginit/nvim/init.vim" "$HOME/.config/nvim/init.vim"
link "$CWD/linux/home/.config/ginit/nvim/ginit.vim" "$HOME/.config/nvim/ginit.vim"

shopt -s extglob
chmod 744 $HOME/bin/!(.gitignore|Gemfile|*.bat)

remember
