#!/bin/sh
dbname=$1
remoteinst=$2
failoverpath=$3


db2 connect to $dbname
set -x
db2 CREATE Bufferpool BFP32K IMMEDIATE SIZE -1 PAGESIZE 32 K
db2 CREATE REGULAR TABLESPACE TSPRGR32K PAGESIZE 32 K MANAGED BY SYSTEM USING\(\'$HOME/${dbname}cntr_32K\'\) EXTENTSIZE 32 OVERHEAD 10.5 PREFETCHSIZE 32 TRANSFERRATE 0.14 BUFFERPOOL "BFP32K" DROPPED TABLE RECOVERY ON

db2 GRANT USE OF TABLESPACE TSPRGR32K TO GROUP CQ
db2 GRANT DBADM ON DATABASE TO USER $remoteinst
db2 CREATE SYSTEM TEMPORARY TABLESPACE TSPTMP32K PAGESIZE 32 K MANAGED BY SYSTEM USING \(\'${HOME}/${dbname}tmp_32K\'\) EXTENTSIZE 32 OVERHEAD 10.5 PREFETCHSIZE 32 TRANSFERRATE 0.14 BUFFERPOOL "BFP32K"


db2 update db cfg for $dbname using APP_CTL_HEAP_SZ 1024
db2 update db cfg for $dbname using SORTHEAP 1024
db2 update db cfg for $dbname using APPLHEAPSZ 1024
db2 update db cfg for $dbname using LOGFILSIZ 1000
db2 update db cfg for $dbname using LOGPRIMARY 15
db2 update db cfg for $dbname using LOGSECOND 10
db2 update db cfg for $dbname using logarchmeth1 TSM
db2 update db cfg for $dbname using FAILARCHPATH $failoverpath
db2 update db cfg for $dbname using trackmod on
#db2 backup db $dbname use tsm

#Call Stephen's script to revoke public on database
/usr/dcertp/bin/db2-revoke-public $dbname