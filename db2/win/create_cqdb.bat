
set CQ_HOME=C:\Program Files\Rational\ClearQuest
set DB2_NODE_PATH=C:\DB2\NODE0000
set DB2_SERVER=minerva.example.org


@echo off
set DBNAME=%1
set DB2_USER=%2
set DB2_PASS=%3

set BP_NAME=bp_%DBNAME%
set RTS_NAME=rts_%DBNAME%
set TTS_NAME=yts_%DBNAME%
set FILE_LOC=%DB2_NODE_PATH%\SQLDBDIR

@echo on
db2 create db %DBNAME% using codeset UTF-8 territory US

db2 connect to %DBNAME% user %DB2_USER% using %DB2_PASS%

db2 create bufferpool %BP_NAME% immediate size 1024 pagesize 32k

db2 create regular tablespace %RTS_NAME% pagesize 32k managed by system using ('%FILE_LOC%\%RTS_NAME%.0') extentsize 16 prefetchsize 16 bufferpool %BP_NAME% overhead 12.67 transferrate 0.18 dropped table recovery off

db2 create temporary tablespace %TTS_NAME% pagesize 32k managed by system using ('%FILE_LOC%\%TTS_NAME%.0') extentsize 16 prefetchsize 16 bufferpool %BP_NAME% overhead 12.67 transferrate 0.18 dropped table recovery off

db2 connect reset

@echo off
REM
REM ClearQuest specific info to setup the packages for use with the DataDirect 5.x drivers as of 7.0.1
REM binddb2pkg usage:
REM    binddb2pkg -h prints this message
REM    binddb2pkg server database user password [port]
REM        If no port is supplied, a port of 50000 is assumed
set BINDDB2PKG=%CQ_HOME%\binddb2pkg.bat
@echo on

"%BINDDB2PKG%" %DB2_SERVER% %DBNAME% %DB2_USER% %DB2_PASS%

