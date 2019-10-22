--Вариант1. Тупо с циклом
DECLARE @test INT
DECLARE @final INT
DECLARE @str1 varchar(100) 

SET @test = (select COUNT(*) from AdventureWorks2014.Person.PersonPhone)

while @test >0 
	begin
		set @str1 = (select right((convert(varchar(100), PhoneNumber)),1) from AdventureWorks2014.Person.PersonPhone pp where pp.BusinessEntityID = @test)
		set @final = convert(int, @str1)
		print @final
		set @test = @test-1
	end


--Вариант2. Оптимизировано
--select PhoneNumber, right((convert(varchar(100), PhoneNumber)),1) as field from AdventureWorks2014.Person.PersonPhone