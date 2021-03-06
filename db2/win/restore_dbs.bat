set DB_LOC=g:\backups\db2\2009\03-14
set BACKUP_DATE=20090314

set DB1_NAME=CRTREPO
set DB1_TS=225917
set DB2_NAME=CRTU001
set DB2_TS=225950
set DB3_NAME=CRTU002
set DB3_TS=230039
set DB4_NAME=CRTU003
set DB4_TS=230115

db2 RESTORE DATABASE %DB1_NAME% FROM %DB_LOC% TAKEN AT %BACKUP_DATE%%DB1_TS% WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 WITHOUT PROMPTING
db2 RESTORE DATABASE %DB2_NAME% FROM %DB_LOC% TAKEN AT %BACKUP_DATE%%DB2_TS% WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 WITHOUT PROMPTING
db2 RESTORE DATABASE %DB3_NAME% FROM %DB_LOC% TAKEN AT %BACKUP_DATE%%DB3_TS% WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 WITHOUT PROMPTING
db2 RESTORE DATABASE %DB4_NAME% FROM %DB_LOC% TAKEN AT %BACKUP_DATE%%DB4_TS% WITH 2 BUFFERS BUFFER 1024 PARALLELISM 1 WITHOUT PROMPTING
