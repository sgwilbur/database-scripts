/*
 Put this file in the directory you start SQL Plus
from and it will load up during login.
*/

set linesize 200;
set pagesize 200;
DEFINE _EDITOR=gvim;
SET SQLPROMPT '&_USER.@&_CONNECT_IDENTIFIER.> ';
