#!/bin/bash
# packlist - list the URI of missing dependencies of a package
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.21 17:14 ==

apt-get --print-uris --yes install $* | sed -n "
  /'/ {
  s/'\([^ ]\+\)'.*/\1/
  p }" | sort
