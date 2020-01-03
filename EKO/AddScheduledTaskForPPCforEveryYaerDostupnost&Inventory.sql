--Скрипт по обновлению графика доступности на ТСД
--Выполнять поочерёдно для to-sql- 01,04,06,08
--Генерить принты и выполнять их в новом окне

-- МЕНЯТЬ ДАТУ НА ПРАВИЛЬНУЮ -- -- МЕНЯТЬ ДАТУ НА ПРАВИЛЬНУЮ -- -- МЕНЯТЬ ДАТУ НА ПРАВИЛЬНУЮ --

SET NOCOUNT ON

declare @dbname varchar(50)
declare @sql varchar(255)

declare NodeList cursor for 
	select name 
	from sys.databases 
	where name like '%ppc_market_%' 
	  and state_desc = 'ONLINE' 
	order by name
open NodeList;
fetch next from NodeList into @dbname
while @@FETCH_STATUS = 0
BEGIN
	

	SET @sql = 'exec ' + @dbname + '.dbo.CreateAvailabilityTasks @date_from = ''20180101'', @date_to = ''20181231''' + char(10)  + 'GO';
	--exec (@sql);
	print @sql;
	--print 'AvailabilityTask created for db ' + @dbname;

fetch next from NodeList into @dbname
END
close NodeList
deallocate NodeList

/*

SELECT TOP (1000) *  FROM [PPC_market_n41].[dbo].[AvailabilitySchedule] where week_day = 2
 
SELECT TOP (1000) *, DATENAME(WEEKDAY ,date_from)
  FROM [PPC_market_n41].[dbo].[Task] where date_from in ('2017-01-05 00:00:00.000', '2018-01-04 00:00:00.000')



SELECT TOP (1000) *
  FROM [PPC_market_n41].[dbo].[TaskDetails] where task_id in (1536, 2111)

  /*
  exec PPC_market_n41.dbo.CreateAvailabilityTasks @date_from = '20180101', @date_to = '20181231'
GO
*/
*/
