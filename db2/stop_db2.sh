#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

su -c "~/das/bin/db2admin stop" dasusr1
su -c "~/sqllib/adm/db2stop" db2inst1


