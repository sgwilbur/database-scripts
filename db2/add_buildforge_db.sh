#REM Tested and fully working as of 9-Feb-10 
#REM

#REM -- 
#REM -- Setup path for the local environment information 
#REM --

export USER=$1
export DBNAME=$2

export SCHEMA=${DBNAME}
export DBPATH=/home/db2inst1/db2inst1/NODE0000/${DBNAME}
export DBALIAS=${DBNAME}

export PAGESIZE=32K
export BPNAME=BUFFP1
export TS_SYSTEMP=TEMPSPACE2
export TS_APPTEMP=BFUSER_TEMP
export TS_APPUSR=USERSPACE2

#-- Create our database
db2 CREATE DATABASE ${DBNAME} ALIAS ${DBALIAS} USING CODESET UTF-8 TERRITORY US AUTOCONFIGURE USING MEM_PERCENT 40 APPLY DB ONLY 

#-- close any open CLI connections 
db2 TERMINATE 

# -- Restart our instance. 
db2stop 
db2start 

# -- Connect to our new database and add the buffer pool. 
db2 CONNECT TO ${DBALIAS}
db2 CREATE BUFFERPOOL ${BPNAME} IMMEDIATE SIZE 1024 PAGESIZE ${PAGESIZE} 

# -- Close connection and reconnect.
db2 CONNECT RESET 
db2 CONNECT TO ${DBALIAS}

# -- Create system/temp/user tablespaces in current database
db2 CREATE SYSTEM TEMPORARY TABLESPACE ${TS_SYSTEMP} PAGESIZE ${PAGESIZE} MANAGED BY SYSTEM USING \(\'${DBPATH}/${TS_SYSTEMP}.0\'\) EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL ${BPNAME} 

db2 CREATE USER TEMPORARY TABLESPACE ${TS_APPTEMP} PAGESIZE ${PAGESIZE} MANAGED BY SYSTEM USING \(\'${DBPATH}/${TS_APPTEMP}.0\'\) EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL ${BPNAME} 

db2 CREATE REGULAR TABLESPACE ${TS_APPUSR} PAGESIZE ${PAGESIZE} MANAGED BY SYSTEM USING \(\'${DBPATH}/${TS_APPUSR}.0\'\) EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL ${BPNAME} 

#-- User must be granted use of TSAPPTEMP tablespace 
db2 GRANT USE OF TABLESPACE ${TS_APPTEMP} TO USER ${USER} WITH GRANT OPTION 
db2 GRANT USE OF TABLESPACE ${TS_APPUSR} TO USER ${USER} WITH GRANT OPTION 
db2 COMMIT WORK
db2 CONNECT RESET 
db2 TERMINATE

db2 CONNECT TO ${DBNAME}
db2 GRANT CREATETAB,CONNECT,IMPLICIT_SCHEMA ON DATABASE TO USER ${USER}
db2 CREATE SCHEMA ${SCHEMA}
db2 SET CURRENT SCHEMA = ${SCHEMA}
#db2 GRANT AlTERIN, CREATEIN, DROPIN ON SCHEMA ${SCHEMA} TO USER ${USER}
db2 GRANT CREATETAB,CONNECT,IMPLICIT_SCHEMA ON DATABASE TO USER ${USER}
db2 GRANT CREATEIN,DROPIN,ALTERIN ON SCHEMA ${SCHEMA} TO USER ${USER} WITH GRANT OPTION
db2 CONNECT RESET
db2 TERMINATE
