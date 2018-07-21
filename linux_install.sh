#!/bin/bash
# linux_install.sh: Install everything

sudo apt-get update
sudo apt-get install -y aptitude
sudo aptitude safe-upgrade -y
# PPA installer
sudo aptitude install -y software-properties-common

# __ BASIC STUFF ________________________

sudo aptitude install -y zsh
sudo aptitude install -y git
sudo aptitude install -y neovim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo aptitude install -y nodejs
sudo npm install -g diff-so-fancy

sudo aptitude install -y meld

echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh

# __ DEVELOPEMENT _______________________

sudo aptitude install -y gcc make
sudo aptitude install -y ctags

sudo aptitude install -y openjdk-11-jdk

sudo aptitude install -y python python-pip python3 python3-pip

sudo aptitude install -y ruby ruby-dev
sudo gem install pry

# __ OTHER ______________________________

sudo pip2 install neovim
sudo pip3 install neovim
sudo gem install neovim
sudo npm install -g neovim

sudo gem install asciidoctor

# Needed by IDEA deployment to work with Vagrant
sudo aptitude install -y gnome-keyring

# __ DESKTOP ____________________________

sudo aptitude install -y neovim-qt
sudo aptitude install -y redshift
# Only conky-all contains nVidia variables
sudo aptitude install -y conky-all

# To autostart window manager:
#   $ cat 'exec awesome' >> ~/.xinitrc OR /etc/X11/xinit/.xinitrc

# sudo aptitude install -y xorg
# sudo aptitude install -y awesome

# __ VIRTUALBOX _________________________

# XORG
#   If installed via apt, it drops segmentation fault:
#     $ sudo aptitude install -y virtualbox-guest-x11
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
