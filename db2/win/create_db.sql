
set DB2_DIR=C:\DB2\NODE0000


db2 create db gbsrdb using codeset UTF-8 territory US

db2 connect to gbuserdb user <DB2 Admin Account>
db2 create bufferpool bp4cq immediate size 250 pagesize 16k

db2 create regular tablespace ts4cq pagesize 16k managed by system using ('%DB2_DIR%') extentsize 16 overhead 12.67 prefetchsize 16 transferrate 0.18 bufferpool bp4cq dropped table recovery off

