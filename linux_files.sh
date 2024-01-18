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

copy "$CWD/linux/.config/"                "$HOME"
link "$CWD/linux/.config/awesome/"        "$HOME/.config/awesome"
link "$CWD/linux/.config/git/"            "$HOME/.config/git"
link "$CWD/linux/.config/i3/"             "$HOME/.config/i3"
link "$CWD/linux/.config/nvim/"           "$HOME/.config/nvim"
link "$CWD/linux/.config/picom/"          "$HOME/.config/picom"
link "$CWD/linux/.config/rofi/"           "$HOME/.config/rofi"
link "$CWD/linux/.config/tmux/"           "$HOME/.config/tmux"
link "$CWD/linux/.config/xfce4/terminal/" "$HOME/.config/xfce4/terminal"
link "$CWD/linux/.config/zsh/"            "$HOME/.config/zsh"
link "$CWD/linux/.nethackrc"              "$HOME/.nethackrc"
link "$CWD/linux/.Xresources"             "$HOME/.Xresources"
link "$CWD/linux/.xsessionrc"             "$HOME/.xsessionrc"
link "$CWD/linux/.zshenv"                 "$HOME/.zshenv"
link "$CWD/linux/bin/"                    "$HOME/bin"

shopt -s extglob
chmod 744 $HOME/bin/!(.gitignore|Gemfile|*.bat)
