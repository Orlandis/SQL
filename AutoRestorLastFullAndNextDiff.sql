drop table #test
create table #test (db_n varchar(100), typ char(1),dt datetime, fil varchar(100))

insert into #test 
SELECT
    bs.database_name,bs.type,
    bs.backup_start_date,
    bmf.physical_device_name
FROM
    msdb.dbo.backupmediafamily bmf
    JOIN
    msdb.dbo.backupset bs ON bs.media_set_id = bmf.media_set_id
WHERE
    bs.database_name not in ('model') --and bs.type = 'D'
	--bs.database_name like '%Test%'
ORDER BY
	bs.backup_start_date
	

select * from #test

drop table #test1
create table #test1 (db_n varchar(100), typ char(1),dt datetime, fil varchar(100))
insert into #test1
select * from #test where dt = (select MAX(dt) from #test where db_n like 'AdventureWorks2014' and typ = 'D') and db_n like 'AdventureWorks2014'
union
select * from #test where dt > (select MAX(dt) from #test where db_n like 'AdventureWorks2014' and typ = 'D') and typ = 'I' and db_n like 'AdventureWorks2014'
union
select * from #test where dt > (select MAX(dt) from #test where db_n like 'AdventureWorks2014' and typ = 'I') and typ = 'L' and db_n like 'AdventureWorks2014'

select * from #test1

--select * from msdb.dbo.backupset
--select * from msdb.dbo.backupfilegroup

select 'RESTORE DATABASE '+db_n+' FROM DISK = '+'''' + fil + ''' NORECOVERY' 
from #test1