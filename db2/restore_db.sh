#~/bin/sh
# ./restore_db.sh <database name> <path to backup> <timestamp>
# $1 - database name
# $2 - path to backup
# $3 - timestamp
#
# Ex. For /home/db2inst1/backups/CRTREPO.0.DB2.NODE0000.CATN0000.20100529182543.001 


db2 restore database $1 from $2 taken at $3 with 2 buffers buffer 1024 parallelism 1 without prompting
