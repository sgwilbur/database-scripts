#!/bin/sh

if [ $# -ne 1 ]
then
    echo "Error in $0 - Invalid Argument Count"
    echo "Syntax: $0 DBNAME"
    exit
fi

dbname=$1

db2 TERMINATE FORCE
db2 DETACH	
db2 ATTACH TO DB2

db2 CONNECT TO  ${dbname}
db2 QUIESCE DATABASE IMMEDIATE FORCE CONNECTIONS
db2 CONNECT RESET
db2 BACKUP DATABASE ${dbname} TO "." WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 COMPRESS  WITHOUT PROMPTING
db2 CONNECT TO ${dbname}
db2 UNQUIESCE DATABASE
db2 CONNECT RESET

DETACH;
TERMINATE;
