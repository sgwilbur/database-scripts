/**************************************************
 * Drop tablespace script
 *
 * Accepts 1 parameters:
 *	&1 - the tablespace to drop
 *
 * Ex usage:
 *	sqlplus system/bighit@sobora10 @ora_droptablespace.sql ts_001
 **************************************************/
DROP TABLESPACE &1 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

exit;