declare @test table (num int identity, fild int, nam varchar(100))

insert into @test select b.file_id, a.name from sys.databases a join sys.master_files b on a.database_id = b.database_id where a.name not in('master', 'tempdb', 'model', 'msdb')

select * from @test

declare @count int = (select COUNT(*) from @test)
declare @folder varchar(100)

while @count > 0 
	begin
	set @folder = (select nam from @test where num = @count)
		if (select fild from @test where num = @count) = 1
			begin
					
			end
	
		else
	set @count = @count - 1  

	end
	