#!/bin/bash
# symlink.sh: symlink-ek letrehozasa az rc fajlokhoz
#
# A $HOME konyvtarba minden fajlrol es konyvtarrol, ami nem _ karakterrel
# kezdodik csinal egy linket. A futtatas elott lepj a script konyvtaraba!
#
# ===================== BimbaLaszlo(.co.nr|gmail.com) ==== 2014.03.31 06:01 ==

# fstab-ba is tedd bele, ne feledd el: chown user /mnt
if [ ! -L $HOME/cuccok ]; then
  ln -si /mnt $HOME/cuccok
fi

for fajl in $(find -maxdepth 1 -not -regex '.\|./_.*\|./\.git\|./readme.md')
do

    # Levesszuk az elejerol a ./ reszt.
    fajl=${fajl##*/}

    # Ha meg nem letezik a link ...
    if [ ! -L $HOME/$fajl ]; then

        # De egy ugyanilyen nevu fajl mar igen, akkor azt elmentjuk '.bak'
        # kitersjesztessel ...
        mv $HOME/$fajl $HOME/$fajl.bak 2> /dev/null

        # ... utanna letrehozzuk a symlink-et.
        ln -s $(pwd)/$fajl $HOME/$fajl
    fi

done

xrdb ~/.Xresources
