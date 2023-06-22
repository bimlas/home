#!/bin/bash
# linux_install.sh: Install everything

sudo apt update
sudo apt upgrade -y

sudo apt install -y zsh
echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh

# PPA installer
sudo apt install -y software-properties-common
# Needed to download installers and GPG keys (Spotify for example)
sudo apt install -y curl
# Needed to use `pip`
sudo apt install -y python3 python3-pip
# GCC, Make, etc.
sudo apt install -y build-essential

sudo apt install -y git

sudo apt install -y tmux
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
pip3 install --user tmuxp

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo apt install -y nnn

bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)

sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - 
sudo apt-get install -y nodejs

curl --location -o ./delta.deb https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
sudo dpkg -i ./delta.deb
rm ./delta.deb

# __ GUI ________________________________

sudo apt install -y xsel

# AutoHotKey for Linux, xautomation is needed for `xte` only
sudo apt install -y xbindkeys # xautomation

# Fuzzy finder GUI
sudo apt install -y rofi

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

sudo apt install -y telegram-desktop

# Vivaldi
curl --location -o ./vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_amd64.deb
sudo dpkg -i ./vivaldi.deb
sudo apt install -y --fix-broken
rm ./vivaldi.deb

# Skype
curl --location -o ./skype.deb https://go.skype.com/skypeforlinux-64.deb
sudo dpkg -i ./skype.deb
sudo apt install -y --fix-broken
rm ./skype.deb

# sudo apt install -y xorg
sudo apt install -y awesome
