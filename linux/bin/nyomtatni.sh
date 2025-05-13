#!/bin/bash

DPI=300
SIDE_MAX_IN_CM=6.7
PADDING=2
#IMAGES_PER_PAGE=5x6
IMAGES_PER_PAGE=4x4
OUT_FILENAME=0_nyomtatni

INCH_IN_CM=2.54
side_max_in_pixels=$(bc <<< "${DPI} / ${INCH_IN_CM} * ${SIDE_MAX_IN_CM}")

tmp=$(mktemp --directory)
for file in *.jpg; do
  convert "$file" -geometry "${side_max_in_pixels}x${side_max_in_pixels}>" "${tmp}/$file";
  if [ $(identify -format "%w" "${tmp}/$file") -gt $(identify -format "%h" "${tmp}/$file") ]; then
    convert "${tmp}/$file" -rotate 90 "${tmp}/$file";
  fi
done

# sorted_by_size=$(identify -format "%[fx:w*h] ${tmp}/%f\n" ${tmp}/*.jpg | sort -rn | cut -d' ' -f2 | grep -v "${OUT_FILENAME}.*.jpg")

sorted_by_size=$(identify -format "${tmp}/%f %w %h\n" ${tmp}/*.jpg | awk '{ printf "%d %s\n", int(int(($2 / $3) * 100) >= 73 && int(($2 / $3) * 100) <= 77), $1 }' | sort -rn | cut -d' ' -f2 | grep -v "${OUT_FILENAME}.*.jpg")

montage -geometry "+${PADDING}+${PADDING}" -tile ${IMAGES_PER_PAGE} -gravity north $sorted_by_size "${OUT_FILENAME}.jpg"
  
rm -rf "${tmp}"

for file in ${OUT_FILENAME}*.jpg; do
  identify -format "%w %h\n" "${file}" | awk '{width=$1/'${DPI}'*'${INCH_IN_CM}'; height=$2/'${DPI}'*'${INCH_IN_CM}'; print "'${file}': " width " cm x " height " cm"}'
done
