#!/bin/sh
# imgoptimize - optimize images in subfolders
#
# jpegtran: libjpeg-progs package
# pngout:   http://www.jonof.id.au/pngout
# The pngout have to be on $PATH.
#
# http://blog.stationfour.com/automating-png-jpg-image-optimization-in-windows/
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

for f in $(find -name '*.jpg'); do
  echo jpegtran: $f
  jpegtran -optimize -progressive -outfile $f -copy none $f
done

for f in $(find -name '*.png'); do
  echo pngout: $f
  pngout $f
done
