#!/bin/sh
# build vim - execute in source root
# https://gist.github.com/jjangsangy/add95bda53c9228905ef
#
# Vim Git repository: https://www.github.com/vim/vim
#
# VIM DEPENDENCIES
#   apt-get build-dep vim
#   apt-get install python-dev  \
#                   python3-dev \
#                   ruby-dev    \
#                   lua-dev
#                   perl-dev    \

# GVIM DEPENDENCIES
#   apt-get install libncurses5-dev  \
#                   libgnome2-dev    \
#                   libgnomeui-dev   \
#                   libgtk2.0-dev    \
#                   libatk1.0-dev    \
#                   libbonoboui2-dev \
#                   libcairo2-dev    \
#                   libx11-dev       \
#                   libxpm-dev       \
#                   libxt-dev
#
# If something went wrong (for example need to upgrade packages) delete
# everything except the .git dir, than `git reset --hard`.
#
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

./configure --with-compiledby="BimbaLaszlo" \
            --with-features=huge            \
            --enable-multibyte              \
            --enable-gui=gtk2               \
            --enable-cscope                 \
            --enable-pythoninterp           \
            --enable-python3interp          \
            --enable-rubyinterp             \
            --enable-luainterp              \
            --enable-perlinterp             \
            --prefix=/usr                   | grep 'gui|python|ruby|lua|perl'

            # --with-python-config-dir="$(python-config --configdir)"   \
            # --with-python3-config-dir="$(python3-config --configdir)" \
            # --with-lua-prefix=/usr/lib/x86_64-linux-gnu               \

echo 'RUN `make`, `make install`'
