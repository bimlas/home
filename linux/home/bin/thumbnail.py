#!/usr/bin/python
# pip2 install pillow

import os, sys
from PIL import Image

size = 128, 128

for infile in sys.argv[1:]:
  outfile = os.path.splitext(infile)[0] + "_small.jpg"
  if infile != outfile:
    try:
      im = Image.open(infile)
      im.thumbnail(size, Image.ANTIALIAS)
      im.save(outfile, "JPEG")
    except IOError:
      print "cannot create thumbnail for '%s'" % infile
