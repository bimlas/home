#!/bin/bash
# linux_install.sh: Install everything

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude
# PPA installer
sudo apt install -y software-properties-common
# Needed to download installers and GPG keys (Spotify for example)
sudo apt install -y curl
# Needed to use `pip`
sudo apt install -y python3 python3-pip

# __ BASIC STUFF ________________________

sudo apt install -y git

sudo apt install -y zsh
echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh

sudo apt install -y tmux
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
pip3 install --user tmuxp

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)

sudo apt install -y neovim

curl -sL https://deb.nodesource.com/setup_lts.x | sudo bash
sudo apt install -y nodejs

sudo npm install -g diff-so-fancy

sudo apt install -y xsel

# __ DEVELOPEMENT _______________________

sudo apt install -y gcc make

#sudo apt install -y openjdk-11-jdk

#sudo apt install -y ruby ruby-dev

#sudo snap install intellij-idea-ultimate --classic

# __ OTHER ______________________________

sudo npm install -g tiddlywiki

# __ DESKTOP ____________________________

#sudo apt install -y vim-gtk
sudo apt install -y redshift
# Only conky-all contains nVidia variables
# sudo apt install -y conky-all
# AutoHotKey for Linux, xautomation is needed for `xte` only
sudo apt install -y xbindkeys # xautomation
# Fuzzy finder GUI
#sudo apt install -y rofi

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# __ NET ________________________________

sudo apt install -y qbittorrent
#sudo apt install -y telegram-desktop

# Vivaldi
curl --location -o ./vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_amd64.deb
sudo dpkg -i ./vivaldi.deb
sudo apt install -y --fix-broken
rm ./vivaldi.deb

# Skype
#curl --location -o ./skype.deb https://go.skype.com/skypeforlinux-64.deb
#sudo dpkg -i ./skype.deb
#sudo apt install -y --fix-broken
#rm ./skype.deb

# TeamViewer
#curl --location -o ./teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#sudo dpkg -i ./teamviewer.deb
#sudo apt install -y --fix-broken
#rm ./teamviewer.deb

# To autostart window manager:
#   $ cat 'exec awesome' >> ~/.xinitrc OR /etc/X11/xinit/.xinitrc

# sudo apt install -y xorg
# sudo apt install -y awesome

# __ VIRTUALBOX _________________________

# XORG
#   If installed via apt, it drops segmentation fault:
#     $ sudo apt install -y virtualbox-guest-x11
#   Use the builtin installer instead
#     Tools -> Install integration services
#     $ sudo mount /dev/cdrom /mnt
#     $ sudo /mnt/VBoxLinuxAdditions.run
#     $ sudo reboot
#   If you cannot `startx` while a window manager is installed, then enable
#   VT-x in BIOS and `echo exec WINDOWMANAGER(awesome) > ~/.xinitrc`.
#   Awesome window manager does not works for some reasons - install `lightdm`
#   ot try `i3`!
#   Update: installed Awesome + LightDM, nothing happened; installed i3, now I
#   can choose awesome from LightDM's list - Awesome does not registers
#   itself?
