#!/bin/sh
# build vim - execute in source root
#
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# VIM DEPENDENCIES
#   apt-get build-dep vim
#   apt-get install ruby-dev python-dev python3-dev perl-dev lua-dev
# GVIM DEPENDENCIES
#   apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
#   libgtk2.0-dev libatk1.0-dev libbonoboui2-dev                 \
#   libcairo2-dev libx11-dev libxpm-dev libxt-dev

./configure --with-compiledby="BimbaLaszlo" \
            --with-features=huge            \
            --enable-multibyte              \
            --enable-gui=gtk2               \
            --enable-cscope                 \
            --enable-rubyinterp             \
            --enable-pythoninterp           \
            --enable-python3interp          \
            --enable-perlinterp             \
            --enable-luainterp              \
            --prefix=/usr

            # --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu       \
            # --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
            # --with-lua-prefix=/usr/lib/x86_64-linux-gnu                               \
echo 'RUN `make`, `make install`'
