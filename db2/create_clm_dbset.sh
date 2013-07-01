#!/bin/sh

USER=$1
ID=$2

function usage()
{
 echo "$0 <user> <identifier>"
 exit 1
}

if [ ! ${USER} ] || [ ! ${ID} ]; then
	usage
fi

if [[ $(expr length ${ID}) > 4 ]]; then
	echo "Attempting to use: [${ID}]"
	echo "Identifier too long, must be 4 characters or less."
	usage
fi


for db in JTS CCM QM CLDW DM VVC
do
	db_name=${db}${ID}
	echo ${db_name}	
	./add_db.sh ${db_name} ${USER}
done

exit 0
