/**************************************************
 * Drop user script:
 *
 * Accepts 1 parameters:
 *	&1 - the username to drop
 *
 * Ex usage:
 *	sqlplus system/bighit@sobora10 @ora_dropuser.sql testuser_001
 **************************************************/
DROP USER &1 CASCADE;

