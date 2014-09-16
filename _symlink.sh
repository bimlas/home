#!/bin/bash
# symlink.sh - automatically symlink/copy files in this directory to $HOME
#
# The working mechanism is based on the name. If the file/directory name in
# this directory starts with:
# __        the script does nothing with it
# _         the file, or the contents of the directory will be copied (the
#           destination will be backuped as '*.bak' if already exists)
# otherwise a symlink will be made
#
# ============ BimbaLaszlo(.co.nr|gmail.com) ============= 2014.06.16 21:43 ==

tmpdir=$(mktemp --directory)
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $here

for file in $(find -maxdepth 1 -not -regex '.\|./\.git\|./readme.adoc')
do
    # Remove ./ from the beginning of the filename.
    file=${file##*/}

    # Leave out.
    if [[ $file =~ ^__ ]]; then
      continue

    # COPY the files and directories and change the '_' to '.'.
    elif [[ $file =~ ^_ ]]; then
      tmpfile=$tmpdir/${file/_/.}
      cp -r $file $tmpfile
      cp -r --backup=simple --suffix=.bak $tmpfile $HOME

    # SYMLINK for files and folders in this directory. (cp cannot create
    # symlink for directories)
    elif [ ! -L $HOME/$file ]; then
      mv $HOME/$file $HOME/$file.bak 2> /dev/null
      ln -s $here/$file $HOME/$file
    fi
done

rm -rf $tmpdir

# Symlink for my mounted partition.
if [ ! -L $HOME/cuccok ]; then
  cd ../../
  ln -si $(pwd) $HOME/cuccok
fi
