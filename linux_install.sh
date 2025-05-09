#!/bin/bash
# linux_install.sh: Install everything

sudo apt update
sudo apt upgrade -y

sudo apt install -y git

sudo apt install -y zsh # zsh-syntax-highlighting
echo '!! Change shell to Zsh needs password'
chsh -s /bin/zsh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.local/share/zsh/fast-syntax-highlighting

# PPA installer
sudo apt install -y software-properties-common
# Needed to download installers and GPG keys (Spotify for example)
sudo apt install -y curl
# Needed to use `pip`
sudo apt install -y python3 python3-pip
# GCC, Make, etc.
sudo apt install -y build-essential autotools-dev autoconf

sudo apt install -y tmux
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
pip3 install --user tmuxp

sudo apt install -y ripgrep
# Needed by some NeoVim plugins to speed up file listings, use as `fdfind`
sudo apt install -y fd-find
# Make symlink, see https://github.com/sharkdp/fd#on-ubuntu
ln -s $(which fdfind) ~/.local/bin/fd

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)

(
  git clone https://github.com/jarun/nnn /tmp/nnn-build
  cd /tmp/nnn-build
  git checkout v4.9
  sudo apt install -y pkg-config libncursesw5-dev libreadline-dev
  sudo make strip install O_GITSTATUS=1
)

# Stable is really old, don't use it
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - 
sudo apt-get install -y nodejs

curl --location -o /tmp/delta.deb https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
sudo dpkg -i /tmp/delta.deb

sudo pip3 install pgcli

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubectl

# __ GUI ________________________________

sudo apt install -y fonts-jetbrains-mono

sudo apt install -y xsel

# Fuzzy finder GUI
sudo apt install -y rofi
# Clipboard manager for rofi
sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /usr/bin/greenclip && sudo chmod +x /usr/bin/greenclip

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# Task manager
sudo apt install -y mate-system-monitor

# Pause mediaplayer by binding
sudo apt install -y playerctl

# # Vivaldi
# curl --location -o ./vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_amd64.deb
# sudo dpkg -i ./vivaldi.deb
# sudo apt install -y --fix-broken
# rm ./vivaldi.deb

# # Skype
# curl --location -o ./skype.deb https://go.skype.com/skypeforlinux-64.deb
# sudo dpkg -i ./skype.deb
# sudo apt install -y --fix-broken
# rm ./skype.deb

sudo apt install -y i3

# (
#   git clone https://github.com/yshui/picom /tmp/picom-build
#   cd /tmp/picom-build
#   git checkout v10.2
#   git submodule update --init --recursive
#   sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
#   meson --buildtype=release . build
#   ninja -C build
#   ninja -C build install
# )
