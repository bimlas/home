#!/bin/bash
# kawoken_sand_colors - automated kawoken coloring
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

echo Remove all customized colors with kawoken-icon-theme-customization before executing!
echo Continue? [y]es [n]o [s]tart kawoken-icon-theme-customization

read ans

case $ans in
  'y')
    ;;
  's')
    kawoken-icon-theme-customization
    exit
    ;;
  'n' | *)
    exit
    ;;
esac

kawoken-icon-theme-customization << EOF
5
n
255
234
179
EOF
