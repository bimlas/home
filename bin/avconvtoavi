#!/bin/sh
# avconvtoavi - convert video to avi

avconv -i $1 -f avi -c:v msmpeg4 -qscale 4 -c:a libmp3lame -ac 2 -ab 192k -ar 44100 $1.avi
