#!/bin/bash
# linux_install.sh: Install everything

sudo apt-get update
sudo apt-get install -y aptitude
sudo aptitude safe-upgrade -y

# __ BASIC STUFF ________________________

sudo aptitude install -y aptitude
sudo aptitude install -y zsh
sudo aptitude install -y git
sudo aptitude install -y vim

echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh

# __ DEVELOPEMENT _______________________

sudo aptitude install -y gcc make
sudo aptitude install -y ctags

sudo aptitude install -y python python-pip python3 python3-pip

sudo aptitude install -y ruby ruby-dev
sudo gem install ripper-tags gem-ripper-tags
sudo gem install pry

# __ DESKTOP ____________________________

# To autostart window manager:
#   $ cat 'exec awesome' >> ~/.xinitrc OR /etc/X11/xinit/.xinitrc

sudo aptitude install -y xorg
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
#   VT-x in BIOS.
#   Awesome window manager does not works for some reasons - try i3!