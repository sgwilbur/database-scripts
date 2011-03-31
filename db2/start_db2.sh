#!/bin/bash

# Must run as root.
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
        echo "Must script as root or with sudo"
        exit
fi


su -c "~/das/bin/db2admin start" dasusr1
su -c "~/sqllib/adm/db2start" db2inst1


