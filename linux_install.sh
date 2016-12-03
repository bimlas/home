#!/bin/bash
# linux_install.sh: Install everything

sudo apt-get update
sudo apt-get -y upgrade

# __ BASIC STUFF ________________________

sudo apt-get install -y aptitude
sudo apt-get install -y zsh
sudo apt-get install -y git
sudo apt-get install -y vim

echo 'Change shell to Zsh needs password'
chsh -s /bin/zsh

# __ DEVELOPEMENT _______________________

sudo apt-get install -y gcc make
sudo apt-get install -y ctags

sudo apt-get install -y python python-pip python3 python3-pip

sudo apt-get install -y ruby ruby-dev
sudo gem install ripper-tags gem-ripper-tags
sudo gem install pry

# __ DESKTOP ____________________________

sudo apt-get install -y xorg awesome
