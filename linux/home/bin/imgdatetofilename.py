#!/usr/bin/python2
# imgdatetofilename - rename file.jpg to date.jpg taken from exif info

import sys
import os
import glob
import exifread

for arg in glob.glob( '*.JPG' ):
  f = open( arg, 'rb' )

  try:
    tags = exifread.process_file( f )
  except Exception as e:
    print "ERROR: " + arg + ": " +  ": " + str( e )
    f.close()
    continue

  f.close()

  if (len( tags ) is 0) or ('EXIF DateTimeOriginal' not in tags.keys()):
    print "SKIP: " + arg
    continue

  fname, fext = os.path.splitext( arg )

  fname = (str( tags['EXIF DateTimeOriginal'] ) + '_' + fname + fext).lower().replace( ':', '.' ).replace( ' ', '_' )
  print arg + " => " + fname
  os.rename( arg, fname )
