
REM -- 
REM -- Setup path for the local environment information 
REM --
set DBNAME=RTC3M7
set SCHEMA=%DBNAME%
set DBPATH=E:\DB2\NODE0000\%DBNAME%
set DBALIAS=%DBNAME%
set USER=RTC

set PAGESIZE=32768

db2 create database %DBNAME% on e: using codeset UTF-8 territory en PAGESIZE %PAGESIZE%

db2 CONNECT TO %DBNAME%
db2 CREATE SCHEMA %SCHEMA%
db2 SET CURRENT SCHEMA = %SCHEMA%
db2 GRANT AlTERIN, CREATEIN, DROPIN ON SCHEMA %SCHEMA% TO %USER%
db2 CONNECT RESET
db2 TERMINATE
