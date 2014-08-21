#!/bin/bash
# packlist-uri - list the missing dependencies of a package
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.21 17:14 ==

apt-get --simulate install $* | sed -n "
  /Inst/ {
  s/^[^ ]\+ \([^ ]\+\) .*/\1/
  p }" | sort
