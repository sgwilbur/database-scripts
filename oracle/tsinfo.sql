select
	tablespace_name, block_size, status, contents
 from dba_tablespaces;

select tablespace_name, (bytes/(1024*1024)) as MiB, SUBSTR(file_name,1,75) as datafile
 FROM dba_temp_files;
