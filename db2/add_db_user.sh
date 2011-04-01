#!/bin/bash


/usr/sbin/useradd -r -d /home/db2inst1 -s /sbin/nologin ${1}

echo "Don't forget to set this user's password now!"
