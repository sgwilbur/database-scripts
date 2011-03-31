/**************************************************
 * Create user script.
 *
 * Accepts 3 parameters:
 *	&1 - the username to create
 *	&2 - the password for this new user
 *	&3 - the new users tablespace
 *
 * Ex usage:
 *	sqlplus system/bighit@sobora10 @createuser.sql testuser_001 testpass ts_001
 **************************************************/
CREATE USER &1 IDENTIFIED BY &2
       DEFAULT TABLESPACE &3 
       TEMPORARY TABLESPACE temp
       QUOTA UNLIMITED ON &3;

GRANT connect,resource TO &1;

