

@echo off
set DBNAME=%1
set USER=%2
set PASS=%3


set BP_NAME=bp_%DBNAME%
set RTS_NAME=rts_%DBNAME%
set TTS_NAME=yts_%DBNAME%
set FILE_LOC=C:\DB2\NODE0000\SQLDBDIR

@echo on
db2 create db %DBNAME% using codeset UTF-8 territory US

db2 connect to %DBNAME% user %USER% using %PASS%

db2 create bufferpool %BP_NAME% immediate size 1024 pagesize 32k

db2 create regular tablespace %RTS_NAME% pagesize 32k managed by system using ('%FILE_LOC%\%RTS_NAME%.0') extentsize 16 prefetchsize 16 bufferpool %BP_NAME% overhead 12.67 transferrate 0.18 dropped table recovery off

db2 create temporary tablespace %TTS_NAME% pagesize 32k managed by system using ('%FILE_LOC%\%TTS_NAME%.0') extentsize 16 prefetchsize 16 bufferpool %BP_NAME% overhead 12.67 transferrate 0.18 dropped table recovery off

db2 connect reset

REM
REM ClearQuest specific info to setup the packages for use with the new DataDirect 5.x drivers
REM binddb2pkg usage:
REM    binddb2pkg -h prints this message
REM    binddb2pkg server database user password [port]
REM        If no port is supplied, a port of 50000 is assumed
@echo off
set BINDDB2PKG=C:\Program Files\Rational\ClearQuest\binddb2pkg.bat
set SERVER=minerva
@echo on

"%BINDDB2PKG%" %SERVER% %DBNAME% %USER% %PASS%

