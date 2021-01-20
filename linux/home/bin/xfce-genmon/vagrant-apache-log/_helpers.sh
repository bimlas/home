#!/bin/sh

case "$2" in
  get_machine_id)
    vagrant global-status | grep "/$1\\s*$" | awk '{print $1}'
    ;;
esac
