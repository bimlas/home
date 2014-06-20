#!/bin/bash
# symlink.sh: symlink-ek letrehozasa az rc fajlokhoz
#
# A $HOME konyvtarba minden fajlrol es konyvtarrol, ami nem _ karakterrel
# kezdodik csinal egy linket ami a script aktualis konyvtaraban levo
# megfelelojere fog linkelni.
# (pl.: /mnt)
#
# ============ BimbaLaszlo(.co.nr|gmail.com) ============= 2014.06.16 21:43 ==

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $here

# Az /etc/fstab-ba is tedd bele, hogy reboot utan is elerheto legyen ez a
# konyvtar.

for fajl in $(find -maxdepth 1 -not -regex '.\|./_.*\|./\.git\|./readme.adoc')
do
    # Levesszuk az elejerol a ./ reszt.
    fajl=${fajl##*/}

    # Ha meg nem letezik a link ...
    if [ ! -L $HOME/$fajl ]; then

        # De egy ugyanilyen nevu fajl mar igen, akkor azt elmentjuk '.bak'
        # kitersjesztessel ...
        mv $HOME/$fajl $HOME/$fajl.bak 2> /dev/null

        # ... utanna letrehozzuk a symlink-et.
        ln -s $here/$fajl $HOME/$fajl
    fi
done

# Symlink letrehozasa a mount-olt meghajtomhoz.
if [ ! -L $HOME/cuccok ]; then
  cd ../../
  ln -si $(pwd) $HOME/cuccok
fi

xrdb ~/.Xresources
