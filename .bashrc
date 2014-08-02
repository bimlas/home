# ~/.bashrc
#
# TIPP: Ha nem ismered a folding hasznalatat, a zR kinyitja az osszes
# konyvjelzot.
#
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.02 09:34 ==

# Ha nem interaktiv modban vagyunk, ne csinaljunk semmit.
if [ -z "$PS1" ]; then
  return
fi

# Kimaszkolja a letrehozott fajlok hozzaferesi jogait. (a tulajdonos mindenre
# fel van hatalmazva, de a csoport tagjainak es mindenki masnak tilos a fajl
# modositasa)
# 133-mal nem birtak a progik a tmp-be irni.
# umask 022

# Ne pittyegjen a speaker.
xset b off

# A history-ban ne legyenek 'dupla sorok' (azaz a tobbszor futtatott parancs
# csak egyszer jelenjen meg), es az ures sorokat torolje.
HISTCONTROL=ignoreboth

HISTSIZE=1000
HISTFILESIZE=2000

# Az uj parancsokat fuzze hozza a history-hoz, ne kezdje uresen.
shopt -s histappend

# A fajlnev-kiegeszites tobb mindent tudjon.
#   ?(LISTA)  Nulla, vagy egy elemre illeszkedik.
#   *(LISTA)  Nulla, vagy bármennyi elemre illeszkedik.
#   +(LISTA)  Legalább egy elemre illeszkedik.
#   @(LISTA)  Az egyik elemre illeszkedik csak.
#   !(LISTA)  A LISTA kivételével mindenre illeszkedik.
shopt -s extglob

# Minden parancs utan mentse el a terminal mereteit. (LINES, COLUMNS)
shopt -s checkwinsize

# Archlinux-szeru prompt.
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
PS1="\n\[\033[1;36m\]\342\224\214\342\224\200"
PS1+="[\[\033[1;37m\]\A\[\033[0m\]\[\033[1;36m\]] \[\033[1;37m\]\w\[\033[0m\]\n"
PS1+="\[\033[1;36m\]\342\224\224\342\224\200 "
PS1+="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]'; else echo '\[\033[1;37m\]'; fi)\\$\[\033[0m\] "
export PS1

# $PATH az Ubuntu-bol, a vegen sajat script konyvtarral.
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/bin:~/bin/xep'

#                                   ALIAS                                 {{{1
# ============================================================================

# Argumentumok kiegeszitese nehany programnal.
if [ -f '/etc/bash_completion' ]; then
  source /etc/bash_completion
fi

alias pm-hibernate='echo "SOSE HASZNALD!"'

# -A                            Minden fajl mutatasa.
# -v                            A szamozott fajlokat szamertek szerint rendezze.
# --color                       Tipus szerinti szinezes.
# --group-directories-first     A konyvtarakat mutassa eloszor.
alias ls='ls -Av --color --group-directories-first'

# Szinezze az illeszkedeseket.
alias grep='grep --color'

# Az eredmenyt bajtokban irja ki.
alias du='du -b'

# vim.tiny ne akarjon .vimrc-t hasznalni
if [ -f '/usr/bin/vim.tiny' ]; then
  alias vim.tiny='vim.tiny -u NONE'
fi

# Az alap saxon-xslt-nek nem tudom atadni, hogy hasznalja a saxon extensions-t
# es xerces legyen az xml parser (ha argumentumkent adjuk at a classpath-ot,
# akkor a $CLASSPATH figyelmen kivul lesz hagyva).
if [ -f '/usr/share/java/saxon.jar' ]; then
  saxon='java -classpath /usr/share/java/saxon.jar'
  if [ -f '/usr/share/java/docbook-xsl-saxon.jar' ]; then
    saxon+=':/usr/share/java/docbook-xsl-saxon.jar'
  fi
  if [ -f '/usr/share/java/xercesImpl.jar' ]; then
    saxon+=':/usr/share/java/xercesImpl.jar                                                              \
            -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl \
            -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl'
  fi
  alias saxon="$saxon com.icl.saxon.StyleSheet"
fi

# Docbook validation.
if [ -f '/usr/share/java/msv-core.jar' ]; then
  msv='java -classpath /usr/share/java/xsdlib.jar'
  msv+=':/usr/share/java/isorelax.jar'
  msv+=':/usr/share/java/relaxngDatatype.jar'
  msv+=':/usr/share/java/msv-testharness.jar'
  msv+=':/usr/share/java/xercesImpl.jar'
  msv+=':/usr/share/java/xml-apis.jar'
  msv+=':/usr/share/java/ant.jar'
  msv+=':/usr/share/java/ant-launcher.jar'
  msv+=':/usr/share/java/xml-resolver.jar'
  msv+=':/usr/share/java/msv-core.jar'
  msv+=' com.sun.msv.driver.textui.Driver'

  alias msv="$msv"
fi

alias asciidoctor="/media/nyolcas/app/asciidoctor/bin/asciidoctor -a allow-uri-read"

# Manual megnyitasa bongeszoben - sajnos nem mindig mukodik.
# if [ -f '/usr/bin/w3mman' ]; then
  # alias man='w3mman'
# fi

# A kepet ne zarja be a gnuplot kilepese utan.
if [ -f '/usr/bin/gnuplot' ]; then
  alias gnuplot='gnuplot -persist'
fi

#                                 FUGGVENYEK                              {{{1
# ============================================================================

#                                 ALTALANOS                               {{{2
# ____________________________________________________________________________

# GUI-val rendelkezo progi futtatasa.

x()
{
  nohup $* &> /dev/null &
}

# Szotar, letoltheto:
# https://github.com/BimbaLaszlo/vim-mixed/blob/master/doc/szotar.txt

szotar()
{
  grep "$@" $HOME/.vim/bundle/vim-mixed/doc/szotar.txt
}

# Rendszerinformaciok osszegzese. (pixelbeat.org)

sysinfo()
{
  find_sbin_cmd() {
    for base in / /usr/ /usr/local; do
      if [ -e $base/sbin/$1 ]; then
        echo $base/sbin/$1
        exit
      fi
    done
  }
  FDISK=`which fdisk 2>/dev/null`
  LSUSB=`which lsusb 2>/dev/null`
  LSPCI=`which lspci 2>/dev/null`
  [ -z "$FDISK" ] && FDISK=`find_sbin_cmd fdisk`
  [ -z "$LSUSB" ] && LSUSB=`find_sbin_cmd lsusb`
  [ -z "$LSPCI" ] && LSPCI=`find_sbin_cmd lspci`

  echo "============= Drives ============="
  (
  sed -n 's/.* \([hs]d[a-f]$\)/\1/p' < /proc/partitions
  [ -e /dev/cdrom ] && readlink -f /dev/cdrom | cut -d/ -f3
  ) |
  sort | uniq |
  while read disk; do
    echo -n "/dev/$disk: "
    if [ ! -r /dev/$disk ]; then
      echo "permission denied" #could parse /proc for all but
    else
      size=`$FDISK -l /dev/$disk | grep Disk | cut -d' ' -f3-4 | tr -d ,`
      rest=`/sbin/hdparm -i /dev/$disk 2>/dev/null | grep Model`
      rest=`echo $rest` #strip spaces
      echo -n "$rest"
      if [ ! -z "$size" ]; then
        echo ", Size=$size"
      else
        echo
      fi
    fi
  done

  #if [ `id -u` == "0" ]; then
  #echo "========== Partitions =========="
  #$FDISK -l 2>/dev/null
  #fi

  echo "============= CPUs ============="
  grep "model name" /proc/cpuinfo #show CPU(s) info

  echo "============= MEM ============="
  KiB=`grep MemTotal /proc/meminfo | tr -s ' ' | cut -d' ' -f2`
  MiB=`expr $KiB / 1024`
  #note various mem not accounted for, so round to appropriate size
  #on my 384MiB system over 8MiB was unaccounted for
  #on my 1024MiB system over 20MiB was unaccounted for so round to next
  #highest power of 2
  round=32
  echo "`expr \( \( $MiB / $round \) + 1 \) \* $round` MiB"

  echo "============= PCI ============="
  $LSPCI -tv

  echo "============= USB ============="
  $LSUSB
}

# Colormap. (https://bbs.archlinux.org/viewtopic.php?id=51818&p=1)

lscolors()
{
  T='gYw'   # The test text

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

#                                PROGRAMOZAS                              {{{2
# ____________________________________________________________________________

# Egy vegrehajthato (binaris) fajl csomagfuggosegeinek listaja - igy
# megtudhatjuk, hogy az altalunk irt program milyen fuggosegekkel rendelkezik.

lsdep()
{
  if [ ! -f /usr/bin/dpkg-shlibdeps ]; then
    echo "A dpkg-shlibdeps nincs telepitve."
    return 1
  fi

  if [ $# -ne 1 ]; then
    echo "Hasznalat: lsdep FAJL" >&2
    return 1
  fi

  if [ ! -f $1 ]; then
    echo "$1: A fajl nem letezik." >&2
    return 1
  fi

  if [ -f debian ]; then
    echo "A vegrehajtashoz szukseges a 'debian' konyvtar" \
         "letrehozasa, de mar letezik ilyen nevu fajl."   >&2
    return 1
  fi

  mkdir debian
  touch debian/control

  # Csomagnevek lekerese, rendezese.
  dpkg-shlibdeps -O "$1" 2> /dev/null | \
  awk                                   \
  '{                                    \
     gsub( /.*Depends=/, "",   $0 );    \
     gsub( /, /,         "\n", $0 );    \
     gsub( /\)/,         " )", $0 );    \
     print $0;                          \
   }'                                 | \
  column -t

  # Ha csak ures fajlok vannak a konyvtarban, toroljuk.
  if [ -z `find debian -type f -size +0` ]; then
    rm -rf debian
  fi

  return 0
}

#                                CSOMGKEZELES                             {{{2
# ____________________________________________________________________________

# Csomag fuggosegei.

packlist()
{
  apt-get --simulate install $* | sed -n "
    /Inst/ {
    s/^[^ ]\+ \([^ ]\+\) .*/\1/
    p }" | sort
}

# Csomag fuggosegei + azok URL cimei.

packlist-uri()
{
  apt-get --print-uris --yes install $* | sed -n "
    /'/ {
    s/'\([^ ]\+\)'.*/\1/
    p }" | sort
}
