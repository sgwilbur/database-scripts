#!/bin/sh
# See http://publib.boulder.ibm.com/infocenter/db2luw/v9/index.jsp?topic=/com.ibm.db2.udb.admin.doc/doc/r0000958.htm
# $1 - Database
# $2 - User to grant permissions

db2 connect $1
db2 grant DBADM on database to USER $2
db2 connect reset
db2 terminate