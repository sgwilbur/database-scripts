REM --
REM -- Setup path for the local environment information
REM --
set DBNAME=%1
set USER=%2

set DB2_DRIVE=C
set DBPATH=%DB2_DRIVE%:\DB2\NODE0000\%DBNAME%

set SCHEMA=%DBNAME%
set DBALIAS=%DBNAME%
set USER=%2%

set PAGESIZE=32768

db2 create database %DBNAME% on %DB2_DRIVE%: using codeset UTF-8 territory en PAGESIZE %PAGESIZE%

db2 CONNECT TO %DBNAME%
db2 CREATE SCHEMA %SCHEMA%
db2 SET CURRENT SCHEMA = %SCHEMA%
db2 GRANT AlTERIN, CREATEIN, DROPIN ON SCHEMA %SCHEMA% TO %USER%
db2 CONNECT RESET
db2 TERMINATE