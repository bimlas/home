#!/bin/sh
# build vim - execute in source root
#
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# apt-get build-dep vim
# apt-get install ruby-dev python-dev python3-dev perl-dev lua-dev

./configure --with-features=huge                                                      \
            --enable-multibyte                                                        \
            --with-compiledby="BimbaLaszlo"                                           \
            --enable-rubyinterp                                                       \
            --enable-pythoninterp                                                     \
            --enable-python3interp                                                    \
            --enable-perlinterp                                                       \
            --enable-luainterp                                                        \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

            # --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu       \
            # --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
            # --with-lua-prefix=/usr/lib/x86_64-linux-gnu                               \
echo 'RUN `make`, `make install`'
