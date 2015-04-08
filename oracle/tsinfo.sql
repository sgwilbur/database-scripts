-- Quick view
select
	tablespace_name, block_size, status, contents
 from dba_tablespaces;
-- http://psoug.org/snippet/TABLESPACE--List-tablespaces-files-allocated-and-free-space_852.htm

-- list all tablespaces with their associated files, the 
-- tablespace's allocated space, free space, and the 
-- next free extent:
clear breaks
SET linesize 130
SET pagesize 60
break ON tablespace_name skip 1
col tablespace_name format a15
col file_name format a50
col tablespace_kb heading 'TABLESPACE|TOTAL KB'
col kbytes_free heading 'TOTAL FREE|KBYTES'
-- 
SELECT dd.tablespace_name tablespace_name, dd.file_name file_name, dd.bytes/1024 TABLESPACE_KB, SUM(fs.bytes)/1024 KBYTES_FREE, MAX(fs.bytes)/1024 NEXT_FREE
FROM sys.dba_free_space fs, sys.dba_data_files dd
WHERE dd.tablespace_name = fs.tablespace_name
AND dd.file_id = fs.file_id
GROUP BY dd.tablespace_name, dd.file_name, dd.bytes/1024
ORDER BY dd.tablespace_name, dd.file_name;
-- 
-- list datafiles, tablespace names, and size in MB:
col file_name format a50
col tablespace_name format a10
-- 
SELECT file_name, tablespace_name, ROUND(bytes/1024000) MB
FROM dba_data_files
ORDER BY 1;
-- 
-- Same for temp tablespace files
SELECT file_name, tablespace_name, ROUND(bytes/1024000) MB
FROM dba_temp_files
ORDER BY 1;
-- 
-- list tablespaces, size, free space, and percent free
-- query originally developed by Michael Lehmann  
SELECT df.tablespace_name TABLESPACE, df.total_space TOTAL_SPACE,
fs.free_space FREE_SPACE, df.total_space_mb TOTAL_SPACE_MB,
(df.total_space_mb - fs.free_space_mb) USED_SPACE_MB,
fs.free_space_mb FREE_SPACE_MB,
ROUND(100 * (fs.free_space / df.total_space),2) PCT_FREE
FROM (SELECT tablespace_name, SUM(bytes) TOTAL_SPACE,
      ROUND(SUM(bytes) / 1048576) TOTAL_SPACE_MB
      FROM dba_data_files
      GROUP BY tablespace_name) df,
     (SELECT tablespace_name, SUM(bytes) FREE_SPACE,
       ROUND(SUM(bytes) / 1048576) FREE_SPACE_MB
       FROM dba_free_space
       GROUP BY tablespace_name) fs
WHERE df.tablespace_name = fs.tablespace_name(+)
ORDER BY fs.tablespace_name;