#~/bin/sh
# ./restore_db.sh <database name> <path to backup> <timestamp>
# $1 - one or more filenames for dbs to restore
#
# 
# Ex. For /home/db2inst1/backups/CRTREPO.0.DB2.NODE0000.CATN0000.20100529182543.001 



for i in "$@"
do
  base_filename=`basename $i`

  database_name=`echo $base_filename| awk -F . {'print $1'}`
  database_timestamp=`echo $base_filename| awk -F . {'print $6'}`
  database_path=`dirname $i`

  echo Restoring $database_name from $database_timestamp @ $database_path
  db2 restore database $database_name from $database_path taken at $database_timestamp with 2 buffers buffer 1024 parallelism 1 without prompting

done
