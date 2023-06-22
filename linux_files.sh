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

cd "$CWD/linux"

link "$CWD/linux/bin/"                    "$HOME/bin"

copy --recursive ".config/" "$HOME"
link "$CWD/linux/.config/awesome/"        "$HOME/.config/awesome"
link "$CWD/linux/.config/nvim/"           "$HOME/.config/nvim"
link "$CWD/linux/.config/rofi/"           "$HOME/.config/rofi"
link "$CWD/linux/.config/xfce4/terminal/" "$HOME/.config/xfce4/terminal"

link "$CWD/linux/.gitconfig_files/"       "$HOME/.gitconfig_files"
link "$CWD/linux/.gitconfig"              "$HOME/.gitconfig"

link "$CWD/linux/.gemrc"                  "$HOME/.gemrc"
link "$CWD/linux/.inputrc"                "$HOME/.inputrc"
link "$CWD/linux/.myclirc"                "$HOME/.myclirc"
link "$CWD/linux/.profile"                "$HOME/.profile"
link "$CWD/linux/.sh_commons"             "$HOME/.sh_commons"
link "$CWD/linux/.tmux.conf"              "$HOME/.tmux.conf"
link "$CWD/linux/.xbindkeysrc"            "$HOME/.xbindkeysrc"
link "$CWD/linux/.Xresources"             "$HOME/.Xresources"
link "$CWD/linux/.xsessionrc"             "$HOME/.xsessionrc"
link "$CWD/linux/.zshrc"                  "$HOME/.zshrc"

shopt -s extglob
chmod 744 $HOME/bin/!(.gitignore|Gemfile|*.bat)
