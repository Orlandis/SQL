--это бэст практис для проверки временных таблиц
if object_id('tempdb..#test') is not null drop table #test
if object_id('tempdb..#test1') is not null drop table #test1
--**************************************************************
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
    --bs.database_name not in ('model') --and bs.type = 'D'
	bs.database_name in ('Test')
ORDER BY
	bs.backup_start_date

--select * from #test
--**************************************************************
create table #test1 (num int identity, db_n varchar(100), typ char(1),dt datetime, fil varchar(100))

if exists (select * from #test where dt = (select MAX(dt) from #test where typ = 'D'))
	begin
		insert into #test1 select * from #test where dt = (select MAX(dt) from #test where typ = 'D')
	end
else goto Metka

if exists (select * from #test where dt > (select MAX(dt) from #test where typ = 'D') and dt = (select MAX(dt) from #test where typ = 'I'))
	begin
		insert into #test1 select * from #test where dt > (select MAX(dt) from #test where typ = 'D') and dt = (select MAX(dt) from #test where typ = 'I')
	end

if exists (select * from #test where dt > (select MAX(dt) from #test where typ = 'I') and typ = 'L')
	begin
		insert into #test1 select * from #test where dt > (select MAX(dt) from #test where typ = 'D') and typ = 'L'
	end

select 'RESTORE '+ (CASE WHEN typ = 'D' THEN 'DATABASE' WHEN typ = 'I' THEN 'DATABASE' WHEN typ = 'L' THEN 'LOG' END)+' '+ db_n + ' FROM DISK = '+'''' + fil + ''' WITH REPLACE, NORECOVERY' from #test1

select * from #test1

--select * from msdb.dbo.backupset
--select * from msdb.dbo.backupfilegroup

Metka: print 'Error u Vas'