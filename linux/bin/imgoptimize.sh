#!/bin/bash
# imgoptimize: Resize and convert to JPG or PNG depending on the file size
#
# Needs ImageMagick
#
# https://stackoverflow.com/a/25997117

convert_to()
{
  convert "$2" -strip -resize "800x800>" -strip -quality 75 $1:-
}

jpg_size=$(convert_to jpg "$1" | wc -c)
png_size=$(convert_to png "$1" | wc -c)
jpg_png_ratio=$(echo $jpg_size*100/$png_size | bc)
target_format=$(if [ $jpg_size -lt $png_size ]; then echo "jpg"; else echo "png"; fi)
if ( identify -format '%[channels]' "$1" | grep "rgba" > /dev/null ); then
  target_format=png
fi

echo "$1: JPG: $(echo $jpg_size/1000 | bc) kbyte, PNG: $(echo $png_size/1000 | bc) kbyte"

convert_to $target_format "$1" > "$(dirname "$1")/RESIZED_$(basename -s ${1#*.} "$1")$target_format"
