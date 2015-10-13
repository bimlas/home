#!/bin/bash
# lsdep - list the dependencies of a binary file (either made by us)
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

if [[ ! -e /usr/bin/dpkg-shlibdeps ]]; then
  echo "A dpkg-shlibdeps nincs telepitve."
  return 1
fi

if [[ $# -ne 1 ]]; then
  echo "Hasznalat: lsdep FAJL" >&2
  return 1
fi

if [[ ! -e $1 ]]; then
  echo "$1: A fajl nem letezik." >&2
  return 1
fi

if [[ -e debian ]]; then
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
if [[ -z `find debian -type f -size +0` ]]; then
  rm -rf debian
fi

return 0
