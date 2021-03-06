REM -- Create our database
db2 CREATE DATABASE BFT ALIAS BUILD USING CODESET UTF-8 TERRITORY US AUTOCONFIGURE USING MEM_PERCENT 40 APPLY DB ONLY 
REM close any open CLI connections 
db2 TERMINATE 

REM -- Restart our instance. 
db2stop 
db2start 

REM -- Connect to our new database and add the buffer pool. 
db2 CONNECT TO BUILD
db2 CREATE BUFFERPOOL "BUFFP1" IMMEDIATE SIZE 1000 PAGESIZE 8192 
db2 CONNECT RESET 
db2 CONNECT TO BUILD 

REM -- 
REM -- Setup path for the local environment information 
REM -- 
set DBPATH=C:\DB2\NODE0000\BFT 

REM -- Create tablespaces 
db2 CREATE SYSTEM TEMPORARY TABLESPACE TEMPSPACE2 PAGESIZE 8192 MANAGED BY SYSTEM USING ('%DBPATH%\SQL003.0') EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL BUFFP1 
db2 CREATE USER TEMPORARY TABLESPACE BFUSE_TEMP PAGESIZE 8192 MANAGED BY SYSTEM USING ('%DBPATH%\SQL004.0') EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL BUFFP1 
db2 CREATE REGULAR TABLESPACE USERSPACE2 PAGESIZE 8192 MANAGED BY SYSTEM USING ('%DBPATH%\SQL005.0') EXTENTSIZE 64 PREFETCHSIZE 64 BUFFERPOOL BUFFP1 

REM -- User must be granted use of BFUSE_TEMP tablespace 
db2 GRANT USE OF TABLESPACE BFUSE_TEMP TO USER BUILD WITH GRANT OPTION 
db2 COMMIT WORK
db2 CONNECT RESET 


db2 CONNECT TO BUILD 
db2 CREATE SCHEMA BUILD
db2 SET CURRENT SCHEMA = BUILD
db2 CONNECT RESET 

db2 TERMINATE