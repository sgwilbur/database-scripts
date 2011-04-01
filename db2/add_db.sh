#!/bin/bash
# $1 - Database name to create
# $2 - User that will own the database

db2inst_home=/home/db2inst1
codeset=UTF-8
territory=en
pagesize=8192

db2 create database $1 on ${db2inst_home} using codeset ${codeset} territory ${territory} pagesize ${pagesize}
db2 connect to $1
#db2 grant dbadm on database to user $2
#db2 revoke connect on database from public

db2 create schema $2
db2 set current schema = $2
db2 grant alterin, createin, dropin on schema $2 to USER $2
db2 connect reset
db2 terminate
