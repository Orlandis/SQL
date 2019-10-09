restore filelistonly from disk = N'D:\BackUp\Full\msdb.bak'

select name, physical_name from sys.master_files

select @@VERSION, @@CONNECTIONS as test


ALTER DATABASE MSDB MODIFY FILE (NAME = MSDBDATA, FILENAME='D:\NoKill\MSDB\MSDBData.mdf');
ALTER DATABASE MSDB MODIFY FILE (NAME = MSDBLOG, FILENAME='D:\NoKill\MSDB\MSDBLog.ldf');

--restore database msdb from disk = 'D:\BackUp\Full\msdb.bak' with replace

select * from sys.dm_server_services

select name, state, state_desc from sys.master_files --where name like '%AdventureWorks2016%'
select name, state, state_desc from sys.databases where name like '%AdventureWorks2016%'
use AdventureWorks2016;
select * from AdventureWorks2016.Person.Address

alter database AdventureWorks2016 set offline WITH ROLLBACK IMMEDIATE;
alter database AdventureWorks2016 set online;
SELECT * FROM sys.sysprocesses WHERE dbid = DB_ID('AdventureWorks2016');
exec sp_who2



