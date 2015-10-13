#!/bin/bash
# packlist - list the URI of missing dependencies of a package
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

apt-get --print-uris --yes install $* | sed -n "
  /'/ {
  s/'\([^ ]\+\)'.*/\1/
  p }" | sort
