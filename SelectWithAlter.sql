--Перевод баз в Offline

--select 'ALTER DATABASE ' + QUOTENAME(d.name) + ' SET OFFLINE WITH ROLLBACK IMMEDIATE'
--	from sys.databases d
--		where d.name not in ('master', 'model', 'msdb', 'tempdb') and d.state_desc = 'ONLINE'
--	order by d.name
--****************************************************

--****************************************************
-- Создание директорий с учётом корневой папки + имен файлов 

--create table #mkdir (id int identity(1,1), fil_id int, name_folder varchar(100))
--insert into #mkdir select b.file_id, b.name from sys.databases a JOIN sys.master_files b ON a.database_id = b.database_id where a.name not in ('master', 'model', 'msdb', 'tempdb') 
--
--declare @cont int
--declare @f_id int
--declare @name_fol varchar(100)
--declare @large_name_fol varchar(100)
--declare @vFileExists table (FileExists int, FileDir int, ParentDirExists int)
--
--set @cont = (select COUNT(*) from #mkdir)
--	while @cont > 0 
--		begin
--			set @f_id = (select fil_id from #mkdir where id = @cont)
--			set @name_fol = (select name_folder from #mkdir where id = @cont)
--				if  @f_id = 1
--					begin
--						set @large_name_fol = 'D:\Test\MDF\'+@name_fol+'\'
--						insert into @vFileExists exec xp_fileexist @large_name_fol
--						exec xp_create_subdir @large_name_fol
--					end
--				else if @f_id = 2
--					begin
--						set @large_name_fol = 'D:\Test\LDF\'+@name_fol+'\'
--						insert into @vFileExists exec xp_fileexist @large_name_fol
--						exec xp_create_subdir @large_name_fol
--					end
--				else if @f_id = 3
--					begin
--						set @large_name_fol = 'D:\Test\NDF\'+@name_fol+'\'
--						insert into @vFileExists exec xp_fileexist @large_name_fol
--						exec xp_create_subdir @large_name_fol
--					end
--	set @cont = @cont - 1
--		end
--drop table #mkdir
--****************************************************


--****************************************************
-- Перенастройка алиасов для файлов баз данных

--select 'ALTER DATABASE '+ a.name + ' MODIFY FILE (NAME = '+b.name+', FILENAME = ''' + REPLACE(physical_name,'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\', (CASE WHEN b.file_id = 1 THEN 'D:\Test\MDF\' WHEN b.file_id = 2 THEN 'D:\Test\LDF\' WHEN b.file_id = 3 THEN 'D:\Test\NDF\' END)+b.name+'\')+''')'
--from sys.databases a JOIN sys.master_files b ON a.database_id = b.database_id 
--where a.name not in ('master', 'model', 'msdb', 'tempdb') 
--****************************************************
--****************************************************

--КОПИРУЕМ ФАЙЛЫ В НУЖНЫЕ ПАПКИ

--****************************************************
--****************************************************
--Перевод баз в Online

--select 'ALTER DATABASE ' + QUOTENAME(d.name) + ' SET ONLINE'
--	from sys.databases d
--		where d.name not in ('master', 'model', 'msdb', 'tempdb') and d.state_desc = 'OFFLINE'
--	order by d.name
--****************************************************