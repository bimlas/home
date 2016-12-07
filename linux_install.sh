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

sudo aptitude install -y xorg
# sudo aptitude install -y awesome
