#!/bin/sh
# avconvtoavi - convert video to avi

avconv -i $1 -vn -f mp3 -ac 2 -ar 44100 -b:a 192k $1.mp3
