#!/bin/bash

db2 create database $1 on /home using codeset UTF-8 territory en PAGESIZE 8192
db2 connect to $1
#db2 grant dbadm on database to user $2
#db2 revoke connect on database from public

db2 create schema $2
db2 set current schema = $2
db2 grant alterin, createin, dropin on schema $2 to USER $2
db2 connect reset
db2 terminate
