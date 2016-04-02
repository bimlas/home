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

header "DEPLOYING ./windows"
cd "$CWD/windows"

header "  COPY"

copy --recursive \
  "AppData"      \
  "Documents"    \
  "$HOME"

header "  SYMLINK"

link "$CWD/windows/Documents/windowspowershell/microsoft.powershell_profile.ps1" "$HOME/Documents/windowspowershell/microsoft.powershell_profile.ps1"

header "DEPLOYING ./linux/home"
cd "$CWD/linux/home"

header "  COPY"

# Windows cannot make symlinks to directories.
copy --recursive                               \
  "bin/"                                       \
  ".gitconfig_files/"                          \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/AppData/Roaming/Mozilla/Firefox/Profiles/*/

copy             \
  _thunderbird/* \
  $HOME/AppData/Roaming/Thunderbird/Profiles/*/

header "  SYMLINK"

link "$CWD/linux/home/.ctags"         "$HOME/.ctags"
link "$CWD/linux/home/.gitconfig"     "$HOME/.gitconfig"
link "$CWD/linux/home/.gemrc"         "$HOME/.gemrc"
link "$CWD/linux/home/.globalrc"      "$HOME/.globalrc"
link "$CWD/linux/home/.gvimrc"        "$HOME/.gvimrc"
link "$CWD/linux/home/.ideavimrc"     "$HOME/.ideavimrc"
link "$CWD/linux/home/.spacemacs"     "$HOME/.spacemacs"
link "$CWD/linux/home/.vimperatorrc"  "$HOME/.vimperatorrc"
link "$CWD/linux/home/.vimrc"         "$HOME/.vimrc"
link "$CWD/linux/home/.vimrc_viewer"  "$HOME/.vimrc_viewer"

remember
