	drop table #test2
	CREATE table #test2 (ID INT IDENTITY(1,1) PRIMARY KEY, NameBase VARCHAR(20), RecoveryMod VARCHAR(6), RecModID TINYINT)

	INSERT INTO #test2 select name, recovery_model_desc, recovery_model FROM sys.databases WHERE name!='tempdb' --AND typerecovery_model_desc
	
	select * from #test2
		
	
	SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'Person'