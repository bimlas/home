#!/bin/bash
# Resize and align *.jpg photos and images of current directory to fit to an A4
# paper for printing

DPI=250
SHORT_SIDE_MAX_IN_MM=50
PADDING_IN_MM=0.1
IMAGES_PER_PAGE=4x4
OUT_FILENAME_PREFIX=bimba_laszlo_a4_${DPI}dpi

INCH_IN_MM=25.4

function mm_to_pix()
{
  bc -l <<< "${DPI} / ${INCH_IN_MM} * ${1}"
}

function pix_to_mm()
{
  bc -l <<< "${1} / ${DPI} * ${INCH_IN_MM}" | xargs printf "%.2f" | tr ',' '.'
}

function size_ratio()
{
  bc -l <<< "$(identify -ping -format '%w / %h' ${1})" | xargs printf "%.2f" | tr ',' '.'
}

function sort_by_ratio_frequency()
{
  for file in $@; do
    echo "$(size_ratio ${file}) ${file}"
  done | sort --numeric-sort > ${tmp_dir}/list_of_ratios

  # Order by aspect ratio frequency
  awk '{print $1}' ${tmp_dir}/list_of_ratios \
    | uniq --count --repeated \
    | sort --numeric-sort --reverse \
    | awk '{print $2}' \
    | while read current; do grep "^${current}" ${tmp_dir}/list_of_ratios | awk '{print $2}'; done

  # Order images with uniq aspect ratio by size descending
  awk '{print $1}' ${tmp_dir}/list_of_ratios \
    | uniq --count --unique \
    | sort --numeric-sort \
    | awk '{print $2}' \
    | while read current; do grep "^${current}" ${tmp_dir}/list_of_ratios | awk '{print $2}'; done
}

tmp_dir=$(mktemp --directory)

file_list=$(find . -maxdepth 1 -type f -name '*.jpg' -not -name "${OUT_FILENAME_PREFIX}*")
file_count=$(wc -l <<< ${file_list})
count=0
for file in ${file_list}; do
  count=$(bc <<< "${count} + 1")
  echo -en "\rRotating and resizing ${count}/${file_count} files..."

  rotate=''
  if (( $(bc -l <<< "$(size_ratio ${file}) > 1") )); then
    rotate='-rotate 90'
  fi

  convert ${file} ${rotate} -geometry "$(mm_to_pix ${SHORT_SIDE_MAX_IN_MM})>x" ${tmp_dir}/$file
done
echo -en "\n"

echo "Creating montage..."
montage \
  -tile ${IMAGES_PER_PAGE} \
  -geometry "+$(mm_to_pix ${PADDING_IN_MM})+$(mm_to_pix ${PADDING_IN_MM})" \
  -gravity north \
  $(sort_by_ratio_frequency ${tmp_dir}/*.jpg) ${OUT_FILENAME_PREFIX}.jpg

rm -rf ${tmp_dir}

for file in ${OUT_FILENAME_PREFIX}*.jpg; do
  echo "${file}: $(pix_to_mm $(identify -format "%w" ${file})) mm x $(pix_to_mm $(identify -format "%h" ${file})) mm"
done
