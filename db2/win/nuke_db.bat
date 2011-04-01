@echo off
rem nuke_db.bat <db server> <database> <db user> <db pass> <connect options>
rem %1 - server 
rem %2 database
rem %3 db user
rem %4 db password
rem %5 connect options

set cleanup_cmds=%TEMP%\cleanup_commands.sql
echo nuke_all_tables; >%cleanup_cmds%
echo quit; >>%cleanup_cmds%
@echo on

pdsql -v db2 -s %1 -db %2 -u %3 -p %4 -noprompt -co %5 <%cleanup_cmds%
