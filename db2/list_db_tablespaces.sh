#!/bin/sh

db2 connect to $1
db2 list tablespaces show detail
db2 connect reset
db2 terminate


