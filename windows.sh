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

if [ $MSYSTEM ]; then
  # Create real symlink instead of copies - needs admin rights.
  export MSYS=winsymlinks:nativestrict
  # Poor way to determine if the user is admin (user cannot run `net session`
  # command).
  net session > /dev/null && export is_win_admin=1 || export is_win_admin=0
fi

source "$CWD/function.sh"

header "DEPLOYING ./windows"
cd "$CWD/windows"

header "  COPY"

copy --recursive   \
  "AppData"        \
  "Documents"      \
  "$HOME"

copy --recursive \
  "app"          \
  "/c"

header "  SYMLINK"

link "$CWD/windows/Documents/windowspowershell/microsoft.powershell_profile.ps1" "$HOME/Documents/windowspowershell/microsoft.powershell_profile.ps1"
link "$CWD/windows/Documents/maya/2015-x64/prefs/userHotkeys.mel" "$HOME/Documents/maya/2015-x64/prefs/userHotkeys.mel"
link "$CWD/windows/Documents/maya/2015-x64/prefs/userColors.mel" "$HOME/Documents/maya/2015-x64/prefs/userColors.mel"
link "$CWD/windows/Documents/maya/2015-x64/prefs/shelves/shelf_Custom.mel" "$HOME/Documents/maya/2015-x64/prefs/shelves/shelf_Custom.mel"

header "DEPLOYING ./linux/home"
cd "$CWD/linux/home"

header "  COPY"

# Windows cannot make symlinks to directories.
copy --recursive                               \
  "bin/"                                       \
  ".gitconfig_files/"                          \
  ".vimrc_minimal"                             \
  "$HOME"

copy         \
  _firefox/* \
  $HOME/AppData/Roaming/Mozilla/Firefox/Profiles/*/

copy             \
  _thunderbird/* \
  $HOME/AppData/Roaming/Thunderbird/Profiles/*/

copy              \
  _intellijidea/* \
  $HOME/.intellijidea*/

header "  SYMLINK"

link "$CWD/linux/home/.ctags"         "$HOME/.ctags"
link "$CWD/linux/home/.emacs"         "$HOME/.emacs"
link "$CWD/linux/home/.gitconfig"     "$HOME/.gitconfig"
link "$CWD/linux/home/.gemrc"         "$HOME/.gemrc"
link "$CWD/linux/home/.gvimrc"        "$HOME/.gvimrc"
link "$CWD/linux/home/.ideavimrc"     "$HOME/.ideavimrc"
link "$CWD/linux/home/.spacemacs"     "$HOME/.spacemacs"
link "$CWD/linux/home/.vimperatorrc"  "$HOME/.vimperatorrc"
link "$CWD/linux/home/.vimrc"         "$HOME/.vimrc"
link "$CWD/linux/home/.vimrc_viewer"  "$HOME/.vimrc_viewer"

remember

if [ $is_win_admin -eq 0 ]; then
    printf "\e[0;33m!!! USED COPY INSTEAD OF SYMLINK: NEEDS ADMIN RIGHTS\e[0m\n"
fi
