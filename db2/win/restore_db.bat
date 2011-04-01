REM %1 - database name
REM %2 - directory 
REM %3 - timestamp yyyymmddhhmmss

REM Sample:
REM E:\home\crt-dbs>E:\home\scripts\db2\restore_db.bat CRTREPO e:\home\crt-dbs\10-13 20091013205507


db2 RESTORE DATABASE %1 FROM %2 TAKEN AT %3 WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 WITHOUT PROMPTING

