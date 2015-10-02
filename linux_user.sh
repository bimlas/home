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

copy --recursive \
  ".aptitude/"   \
  ".config/"     \
  ".dosbox/"     \
  ".kde/"        \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/.mozilla/firefox/*.default/

copy             \
  _thunderbird/* \
  $HOME/.thunderbird/*.default/

header "  SYMLINK"

link "$CWD/linux/home/bin/"           "$HOME/bin"
link "$CWD/linux/home/.git_template/" "$HOME/.git_template"
link "$CWD/linux/home/.pentadactyl/"  "$HOME/.pentadactyl"
link "$CWD/linux/home/.bashrc"        "$HOME/.bashrc"
link "$CWD/linux/home/.conkyrc"       "$HOME/.conkyrc"
link "$CWD/linux/home/.ctags"         "$HOME/.ctags"
link "$CWD/linux/home/.gitconfig"     "$HOME/.gitconfig"
link "$CWD/linux/home/.globalrc"      "$HOME/.globalrc"
link "$CWD/linux/home/.gvimrc"        "$HOME/.gvimrc"
link "$CWD/linux/home/.ideavimrc"     "$HOME/.ideavimrc"
link "$CWD/linux/home/.inputrc"       "$HOME/.inputrc"
link "$CWD/linux/home/.pentadactylrc" "$HOME/.pentadactylrc"
link "$CWD/linux/home/.profile"       "$HOME/.profile"
link "$CWD/linux/home/.spacemacs"     "$HOME/.spacemacs"
link "$CWD/linux/home/.sh_commons"    "$HOME/.sh_commons"
link "$CWD/linux/home/.vimrc"         "$HOME/.vimrc"
link "$CWD/linux/home/.Xresources"    "$HOME/.Xresources"
link "$CWD/linux/home/.xsessionrc"    "$HOME/.xsessionrc"
link "$CWD/linux/home/.zshrc"         "$HOME/.zshrc"

cd "$CWD/../../"
link "`pwd`" "$HOME/cuccok"
