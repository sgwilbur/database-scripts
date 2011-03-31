SET ESCAPE ON
SET ESCAPE "\"


select user_id, username, account_status,
	default_tablespace, temporary_tablespace
	from dba_users
	where account_status <> 'EXPIRED \& LOCKED'
;

SET ESCAPE OFF
