#!/bin/sh
# $1 - database name

db2 connect to $1
# http://www.dbtalks.com/UploadFile/iersoy/979/
db2 "call get_dbsize_info(?,?,?,0)" 
db2 connect reset
db2 terminate