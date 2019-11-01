declare
@oldpath varchar(255),
@newpath_data varchar(255),
@newpath_log varchar(255)

set @oldpath ='D:\MSSQL\DATA'
set @newpath_data ='E:\MSSQL14.AUTODESKVAULT\MSSQL\DATA' 
set @newpath_log ='F:\MSSQL14.AUTODESKVAULT\MSSQL\DATA' 

SELECT 'alter database ' + QUOTENAME(d.name) + ' modify file (name = ' + QUOTENAME(mf.name) + ', filename = ''' + 
		case when mf.type_desc = 'LOG' then replace(mf.physical_name,@oldpath,@newpath_log) + ''');'
			 else replace(mf.physical_name,@oldpath,@newpath_data) + ''');' 
		end + char(13) + 'GO' 
FROM sys.master_files mf
	join sys.databases d on d.database_id = mf.database_id
where d.[name] not in ('master', 'model', 'msdb', 'tempdb')
