#!/bin/bash
# linux_install.sh: Install everything

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude
# PPA installer
sudo apt install -y software-properties-common

# __ BASIC STUFF ________________________

sudo apt install -y zsh
echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo apt install -y vim

sudo apt install -y git

sudo apt install -y nodejs npm
sudo npm install -g diff-so-fancy

# __ DEVELOPEMENT _______________________

sudo apt install -y gcc make

sudo apt install -y openjdk-11-jdk

sudo apt install -y python python-pip python3 python3-pip

sudo apt install -y ruby ruby-dev

# __ OTHER ______________________________

sudo pip2 install neovim
sudo pip3 install neovim

sudo npm install -g tiddlywiki

# __ DESKTOP ____________________________

sudo apt install -y vim-gtk
sudo apt install -y redshift
# Only conky-all contains nVidia variables
sudo apt install -y conky-all
# AutoHotKey for Linux, xautomation is needed for `xte` only
sudo apt install -y xbindkeys # xautomation

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
