/**************************************************
 * Create tablespace script:
 *
 * Accepts 4 parameters:
 *	&1 - the tablespace to create
 *	&2 - the file location
 *	&3 - initial size
 *	&4 - max size
 *
 * Ex usage:
 *	sqlplus system/bighit@sobora10 @createts.sql ts_001 \var\db\oracle\ts_001.dbf 100M 500M
 **************************************************/
CREATE TABLESPACE &1
	DATAFILE '&2'
		SIZE &3
		AUTOEXTEND ON NEXT 10M
		MAXSIZE &4
	NOLOGGING
	PERMANENT
	EXTENT MANAGEMENT LOCAL	UNIFORM SIZE 1M;

