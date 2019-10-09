
select 'ALTER DATABASE ' + QUOTENAME(d.name) + ' SET OFFLINE WITH ROLLBACK IMMEDIATE' ColsName
from sys.databases d
where d.name not in ('master', 'model', 'msdb', 'tempdb') 
  and d.state_desc = 'ONLINE'
order by d.name

--alter database AdventureWorks2014 set online