#!/bin/sh

mkdir kesz
for i in *.jpg *.png *.bmp *.gif
  do avconv -v 20 -i $i -vf "pad=width=max(iw\,ih)+1:height=max(iw\,ih)+1:x=(ow-iw)/2:y=(oh-ih)/2:color=white" kesz/$i
done
