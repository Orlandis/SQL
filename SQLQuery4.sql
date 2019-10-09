
CREATE PROCEDURE UserBackUp (@BackupType varchar(6))
	AS
		BEGIN
			DECLARE @bak_path VARCHAR(20)
			DECLARE @name VARCHAR(20)
			DECLARE @RM TINYINT
			DECLARE @pathb VARCHAR(60)
			DECLARE @pathl VARCHAR(60)
			--DECLARE @directory VARCHAR(2)
			SET @bak_path = 'D:\BackUp\Full\';
			DECLARE @date VARCHAR(10)
			DECLARE @time VARCHAR(8)

			SET @date = REPLACE(CONVERT(CHAR(10), GETDATE(), 104),'.','')
			SET @time = REPLACE(CONVERT(CHAR(8), GETDATE(), 108),':','')
			DECLARE @counnt_writes INT

			--CREATE table #test2 (ID INT IDENTITY(1,1) PRIMARY KEY, NameBase VARCHAR(20), RecoveryMod TINYINT)
			CREATE table #test2 (ID INT IDENTITY(1,1) PRIMARY KEY, NameBase VARCHAR(20), RecoveryMod VARCHAR(6))

			INSERT INTO #test2 select name, recovery_model_desc FROM sys.databases WHERE name!='tempdb'
			select * from #test2
			
			SET @counnt_writes = (select COUNT(*) FROM #test2)

				WHILE @counnt_writes > 0
					BEGIN
						--SET @directory = (CONVERT(CHAR(1), @counnt_writes))+N'\'
						SET @name = (SELECT NameBase FROM #test2 WHERE ID = @counnt_writes)
						SET @RM = (SELECT RecoveryMod FROM #test2 WHERE ID = @counnt_writes)
						--SET @pathb = @bak_path+@directory+@name+'_'+@date+'_'+@time+'.bak'
						--SET @pathl = @bak_path+@directory+@name+'_'+@date+'_'+@time+'.trn'
						
						SET @pathb = @bak_path+@name+'_'+@date+'_'+@time+'.bak'
						SET @pathl = @bak_path+@name+'_'+@date+'_'+@time+'.trn'						
		
						IF @RM = 1
							BEGIN
								BACKUP DATABASE @name TO DISK = @pathb;
								BACKUP LOG @name TO DISK = @pathl;
								SET @counnt_writes = @counnt_writes - 1;
							END
						ELSE 
								BACKUP DATABASE @name TO DISK = @pathb;
								SET @counnt_writes = @counnt_writes - 1;
					END
		END
DROP TABLE #test2