#!/bin/bash
# symlink.sh - automatically symlink/copy files in this directory to $HOME
#
# The working mechanism is based on the name. If the file/directory name in
# this directory starts with:
# __        the script does nothing with it
# _         the file, or the contents of the directory will be copied (the
#           destination will be backuped as '*~N~' if already exists)
# otherwise a symlink will be made
#
# ============ BimbaLaszlo(.co.nr|gmail.com) ============= 2014.06.16 21:43 ==

tmpdir=$(mktemp --directory)
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $here

#  Have to improve the creation of symlinks in directories.
mkdir $HOME/bin

for file in $(find -maxdepth 1 -not -regex '.\|./\.git\|./readme.adoc')
do
    # Remove ./ from the beginning of the filename.
    file=${file##*/}

    if [[ $file =~ ^__ ]]; then
      echo "LEAVE OUT: $file"
      continue

    elif [[ $file =~ ^_ ]]; then
      echo "COPY:      $file"
      tmpfile=$tmpdir/${file/_/}
      cp -r $file $tmpfile
      cp -r --backup=numbered $tmpfile $HOME

    else
      for i in $(find $file -type f); do
        echo "SYMLINK:   $i"
        if [ -e $HOME/$i ] && [ ! -L $HOME/$i ]; then
          cp --backup=numbered --symbolic-link $here/$i $HOME
        else
          cp --force --symbolic-link $here/$i $HOME/$i
        fi
      done
    fi
done

rm -rf $tmpdir
