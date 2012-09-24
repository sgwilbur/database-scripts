#!/bin/sh
# List using the priveleges adminstrative view.
# http://publib.boulder.ibm.com/infocenter/db2luw/v9/index.jsp?topic=/com.ibm.db2.udb.admin.doc/doc/r0021978.htm
# $1 - Database

db2 connect to $1
db2 SELECT AUTHID, PRIVILEGE, OBJECTNAME, OBJECTSCHEMA, OBJECTTYPE FROM SYSIBMADM.PRIVILEGES
db2 connect reset
db2 terminate