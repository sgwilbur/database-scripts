rem ********************************************************************
rem * Author            : Rick Kupcunas
rem * Original          : 07-NOV-95
rem * Description       : Show the analyze statistics of all tables
rem *
rem ********************************************************************

spool all_stat.rslt;

set pagesize 100;
set linesize 132;
break on "OWNER" on "VIEW";

set echo on;

/* ********************* */
/* statistics for tables */
/* ********************* */

set echo off;

select substr(owner,1,8)                                   "OWNER",
       substr(table_name,1,25)                          "TABLE",
       substr(to_char(pct_used, '99'),1,3)              "% USED",
       substr(to_char(pct_free, '99'),1,3)                     "% FREE",
       substr(to_char(num_rows, '99,999'),1,7)         "ROWS",
       substr(to_char(blocks, '99,999'),1,7)             "BLKS",
       substr(to_char(empty_blocks, '99,999'),1,7)      "EMPTY BLKS",
       substr(to_char(avg_space, '99,999'),1,7)             "AVG SPACE",
       substr(to_char(chain_cnt, '9,999'),1,5)              "CHAINING",
       substr(to_char(avg_row_len, '999'),1,4)               "ROW LEN",
       cache                                          "CACHE"
  from sys.all_tables
  where owner <> 'SYS' and
        owner <> 'SYSTEM'
  order by 1, 2;

set echo on;

/* ********************* */
/* statistics for indexes */
/* ********************* */

set echo off;

select substr(owner,1,8)                                     "OWNER",
       substr(table_name,1,25)                               "TABLE",
       substr(index_name,1,25)                               "INDEX",
       decode(uniqueness,'UNIQUE', 'Yes', 'No')              "UNQ?",
       substr(to_char(distinct_keys, '999,999'),1,8)         "#Keys",
       substr(to_char(avg_leaf_blocks_per_key, '999'),1,4)   "Leaf/Key",
       substr(to_char(avg_data_blocks_per_key, '999'),1,4)   "Blks/Key",
       substr(to_char(clustering_factor, '99,999'),1,7)      "Clust Fct"
  from sys.all_indexes
  where owner <> 'SYS' and
        owner <> 'SYSTEM'
  order by 1, 2;

set echo on;
spool off;
commit;
