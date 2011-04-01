#!/bin/bash
# $1 - Username to delete

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

/usr/sbin/userdel ${1}
