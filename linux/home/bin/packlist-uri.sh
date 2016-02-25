#!/bin/bash
# packlist-uri - list the missing dependencies of a package
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

apt-get --simulate install $* | sed -n "
  /Inst/ {
  s/^[^ ]\+ \([^ ]\+\) .*/\1/
  p }" | sort
