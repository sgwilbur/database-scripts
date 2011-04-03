#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

/usr/sbin/useradd -r -d /home/db2inst1 -s /sbin/nologin ${1}

echo "Remember to add to the correct DB2 user groups."
echo "Don't forget to set this user's password now!"
