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

                                                               # TODO: tmpname
tmpdir=$HOME/tmp$RANDOM
mkdir $tmpdir

for fajl in $(find -maxdepth 1 -not -regex '.\|./\.git\|./readme.adoc')
do
    # Levesszuk az elejerol a ./ reszt.
    fajl=${fajl##*/}

                                                          # TODO: [[ x =~ y ]]
    # Leave out.
    if ( echo $fajl | grep -E '^__' ); then
      continue

    # COPY the files and directories and change '_' to '.'.
    elif (echo $fajl | grep -E '^_' ); then
      tmpfile=$tmpdir/${fajl/_/.}
      cp -r $fajl $tmpfile
      cp -r --backup=simple --suffix=.bak $tmpfile $HOME

    # SYMLINK for files and folders in this directory.
    elif [ ! -L $HOME/$fajl ]; then
      cp --symbolic-link --backup=simple --suffix=.bak $tmpfile $HOME
    fi
done

rm -rf $tmpdir

# Symlink letrehozasa a mount-olt meghajtomhoz.
# Az /etc/fstab-ba is tedd bele, hogy reboot utan is elerheto legyen ez a
# konyvtar.
if [ ! -L $HOME/cuccok ]; then
  cd ../../
  ln -si $(pwd) $HOME/cuccok
fi
