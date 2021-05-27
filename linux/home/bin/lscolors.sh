#!/bin/zsh
# lscolors - list the colors in terminal
# https://bbs.archlinux.org/viewtopic.php?id=51818&p=1
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

emulate -L zsh

colorpicker() {
  T='sample'   # The test text

  echo -e "                 40m     41m     42m     43m     44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
              '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
              '  36m' '1;36m' '  37m' '1;37m'; do

    FG=${FGs// /}

    echo -en " $FGs \033[$FG  $T  "

    for BG in 40m 41m 42m 43m 44m 45m 46m 47m
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m"
    done

    echo

  done
}

local columns=${COLUMNS:-$(tput cols || echo 80)}

local cawk='BEGIN{ for (color = start; color<=end; color++) { printf "\033[48;5;%dm  ", color }  printf "\033[0m\n" }'

systemcolors() {
  print 'System colors:'
  awk -v start=0 -v end=7 $cawk
  awk -v start=8 -v end=15 $cawk
}

colorcube() {
  local cs=6
  print "Color cube, ${cs}x${cs}x${cs}:"
  awk -v cs=$cs 'BEGIN{
    bo = cs * cs;
    bl = cs - 1;
    for (ri=0; ri<cs; ri++) {
      for (bi=0; bi<cs; bi++) {
        bs = 16 + ( bo * bi ) + ( cs * ri );
        be = bs + bl
        for (i=bs; i<=be; i++) {
          printf "\033[48;5;%dm  ", i
        }
        printf "\033[0m";
      }
      print
    }
    printf "\033[0m"
  }'
}

grayscale() {
  print 'Grayscale ramp:'
  awk -v start=232 -v end=255 $cawk
}

truecolor() {
  # https://unix.stackexchange.com/questions/404414/print-true-color-24-bit-test-pattern/404415#404415
  print 'Truecolor ramp:'
  local tawk='BEGIN{
    for (colnum = 0; colnum<term_cols; colnum++) {
        r = 255-(colnum*255/term_cols);
        g = (colnum*510/term_cols);
        b = (colnum*255/term_cols);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
  }'
  awk -v s="  " -v term_cols="${columns}" $tawk
  awk -v s="/\\\\" -v term_cols="${columns}" $tawk
  awk -v s="  " -v term_cols="${columns}" $tawk
}

textstyles() {
  print 'Text styles:'
  print '• \e[1mBold (\\e[1m)\e[0m'
  print '• \e[2mStandout (\\e[2m)\e[0m'
  print '• \e[3mItalic (\\e[3m)\e[0m'
  print '• \e[4mUnderline (\\e[4m)\e[0m'
  print '• \e[4:2mDoubleUnderline (\\e[4:2m)\e[0m'
  print '• \e[9mStrikethrough (\\e[9m)\e[0m'
  print '• \e[7mReverse (\\e[7m)\e[0m'
  print '• \e[8mHidden\e[0m  (\\e[8m Hidden)'
}

colorbands() {
  print 'Colors bands:'
  #( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )
  (( columns = $columns - 10 ))
  awk -v start=0 -v end=256 "BEGIN{
      for (color=start; color<end; color++) {
        printf \"\033[48;5;%dm% ${columns}s\033[0m\n\", color, \"\"
      }
    }" \
    | nl -v0
}

print TERM=$TERM
colorpicker;print
systemcolors;print
colorcube;print
grayscale;print
truecolor;print
textstyles;print
[ "$1" = "-b" ] && colorbands
