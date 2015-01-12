# #!/bin/sh - build vim - execute in source root
#
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# Try out withou gnome.
# sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev        \
#     libgtk2.0-dev libatk1.0-dev libbonoboui2-dev                         \
#     libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev \
#     ruby-dev

./configure --with-features=huge                                                    \
            --enable-multibyte                                                      \
            --with-compiledby="BimbaLaszlo"                                         \
            --enable-rubyinterp                                                     \
            --enable-pythoninterp                                                   \
            --with-python-config-dir=/usr/lib/python2.7/config-i386-linux-gnu       \
            --enable-python3interp                                                  \
            --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-i386-linux-gnu \
            --enable-perlinterp                                                     \
            --enable-luainterp                                                      \
            --with-lua-prefix=/usr/lib/i386-linux-gnu                               \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

echo 'RUN MAKE'
