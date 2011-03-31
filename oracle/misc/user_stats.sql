set echo off;
rem ********************************************************************
rem * Author            : Rick Kupcunas
rem * Original          : 07-NOV-95
rem * Description       : Show the analyze statistics of all tables
rem * original @  http://home1.gte.net/rkupcuna/sql/all_stat.sql
rem ********************************************************************
/* modified liberally 06-Feb-07 _ swilbur
 *
 * Ex usage:
 *	sqlplus system/bighit@sobora10 @user_stats.sql username
 */

set showmode off;
set pagesize 100;
set linesize 120;

spool user_stats.rslt;

select substr(t1.owner,1,8)				"OWNER",
       substr(t1.table_name,1,25)			"TABLE",
       t1.num_rows					"ROWS",
       t1.blocks					"BLKS",
	(t1.blocks * t2.Value)/1024			"Size MB",
       t1.empty_blocks					"EMPTY BLKS",
       substr(to_char(t1.avg_space, '99,999'),1,7)	"AVG SPACE",
       substr(to_char(t1.chain_cnt, '9,999'),1,5)	"CHAINING",
       substr(to_char(t1.avg_row_len, '999'),1,4)	"ROW LEN",
       cache						"CACHE"
  from sys.all_tables t1, v$parameter t2
  where t1.owner =  UPPER('&1') and t2.name = 'db_block_size' 
  order by 1, 5 desc;

spool off;
commit;
set echo on;
