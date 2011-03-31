set feedback off;
set echo off;
set linesize 130;

rem ********************************************************************
rem * Author            : Rick Kupcunas
rem * Original          : 18-MAY-95
rem * Description       : Shows the size occupied by a table
rem * Usage             : start size_tab.sql <date>  e.g. 03-MAR-95
rem *
rem * for this to be useful be sure to run a compute on this table
rem * analyze table <table> compute statistics;
rem *
rem ********************************************************************
set echo off;

spool size_tab.rslt;

/* **************************** */
/*  Get the database block-size */
/* **************************** */

column db_block_size new_value BLOCK_SIZE
select to_char(value, '9,999,999,999') 	"DB Block Size"
from v$parameter
where name = 'db_block_size';

set pagesize 60;
set linesize 120;
break on "OWNER";
set echo off;

set echo on;
/* *********************************** */
/* Show tablespaces and datafiles      */

/* *********************************** */
col file_name format a50
col tablespace_name format a10

SELECT file_name, tablespace_name, ROUND(bytes/1024000) MB
FROM dba_data_files
ORDER BY file_name;

SELECT file_name, tablespace_name, ROUND(bytes/1024000) currentMB, ROUND(maxbytes/1024000) maxMB
FROM dba_data_files
	WHERE tablespace_name like 'TI%'
ORDER BY file_name;



/* *********************************** */
/*   A ...... average row length       */
/*   B ...... size of table in blocks  */
/*   C ...... free data blocks         */
/*   D ...... actual bytes per block   */
/*   E ...... percentage of space used */
/* *********************************** */
set echo off;

select 
     substr(A.owner,1,10)                                   "OWNER",
     substr(A.table_name,1,30)                              "TABLE",
     substr(to_char(A.num_rows, '99,999,999'),1,11)         "# ROWS",              
     substr(to_char(A.avg_row_len, '9,999.99'),1,10)           "--A-",
     substr(to_char(A.blocks, '99,999'),1,7)                "---B---",
     substr(to_char(A.empty_blocks, '99,999'),1,7)          "---C---",
     substr(to_char((b.Value - A.avg_space), '9,999'),1,6)  "--D--",
     substr(to_char(ABS((1 - (nvl(A.empty_blocks,0)/A.blocks))*100),
                           '999.99'),1,7)                   "--E--"
from  sys.dba_tables A,
      v$parameter    B
where A.table_name = upper('&&TABLE_NAME') and
      A.num_rows is not null               and 
      A.blocks > 0                         and
      B.name = 'db_block_size'
order by 1 asc, 2 asc, 3 asc;

set echo on;

/* *********************************** */
/*   F ...... toyal space available    */
/*            (in bytes)               */
/*   F1 ...... toyal space available   */
/*            (in Mbytes)              */
/*   G ...... size of space used       */
/*            (in bytes)               */
/*   G1 ...... size of space used      */
/*            (in Mbytes)              */
/*                                     */
/* *********************************** */

set echo off;

select 
     substr(A.owner,1,10)                                    "OWNER",
     substr(A.table_name,1,30)                               "TABLE", 
     substr(to_char((A.blocks + nvl(A.empty_blocks,0))*b.Value,
                           '999,999,999'),1,12)               "--F--",
     substr(to_char(((A.blocks + nvl(A.empty_blocks,0))*b.Value)/(1024*1024),
                           '999,999.999'),1,12)               "--F1--",
     substr(to_char((nvl(A.blocks,0))*
                           (b.Value - A.avg_space), 
                           '999,999,999'),1,12)               "--G--",
     substr(to_char(((nvl(A.blocks,0))*
                           (b.Value - A.avg_space))/(1024*1024), 
                           '999,999.999'),1,12)               "--G1--"
from  sys.dba_tables A,
      v$parameter    B
where A.table_name = upper('&&TABLE_NAME') and
      A.num_rows is not null               and 
      A.blocks > 0                         and
      B.name = 'db_block_size'
order by 1 asc, 2 asc, 3 asc;

set echo on;

/* *********************************** */
/*   H ...... size of space free       */
/*            (in bytes)               */
/*   H1 ...... size of space free      */
/*            (in Mbytes)              */
/*                                     */
/* *********************************** */

set echo off;

select 
     substr(A.owner,1,10)                                    "OWNER",
     substr(A.table_name,1,30)                               "TABLE", 
     substr(to_char((nvl(A.empty_blocks,0))*
                           (b.Value - A.avg_space), 
                           '999,999,999'),1,12)               "--H--",
     substr(to_char(((nvl(A.empty_blocks,0))*
                           (b.Value - A.avg_space))/(1024*1024), 
                           '999,999.999'),1,12)               "--H1--"
from  sys.dba_tables A,
      v$parameter    B
where A.table_name = upper('&&TABLE_NAME') and
      A.num_rows is not null               and 
      A.blocks > 0                         and
      B.name = 'db_block_size'
order by 1 asc, 2 asc, 3 asc;

spool off;
set echo off;
set feedback on;

undefine BLOCK_SIZE;
undefine TABLE_NAME;
commit;
