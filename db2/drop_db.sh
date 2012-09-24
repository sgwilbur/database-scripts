#!/bin/bash
# $1 - Database to drop
for i in "$@"
do
	db2 drop database $i
done
