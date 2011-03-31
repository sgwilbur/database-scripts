REM http://www.dbspecialists.com/presentations/use_explain.html
REM explain.sql
REM

SET VERIFY OFF
SET PAGESIZE 100

ACCEPT stmt_id CHAR PROMPT "Enter statement_id: "

COL id          FORMAT 999
COL parent_id   FORMAT 999 HEADING "PARENT"
COL operation   FORMAT a35 TRUNCATE
COL object_name FORMAT a30

SELECT     id, parent_id, LPAD (' ', LEVEL - 1) || operation || ' ' ||
           options operation, object_name
FROM       plan_table
WHERE      statement_id = '&stmt_id'
START WITH id = 0
AND        statement_id = '&stmt_id'
CONNECT BY PRIOR
           id = parent_id
AND        statement_id = '&stmt_id';

