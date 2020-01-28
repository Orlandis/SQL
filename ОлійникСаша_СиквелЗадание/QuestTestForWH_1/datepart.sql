
use Sasha
go
--declare @Ta int
--set @Ta = 10455836
--select dateadd(hour, (@T / 1000000) % 100, dateadd(minute, (@T / 10000) % 100, dateadd(second, (@T / 100) % 100, dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))
--set @T = 421151

--select (@T / 1000000) % 100 as hour,
--       (@T / 10000) % 100 as minute,
--       (@T / 100) % 100 as second,
--       (@T % 100) * 10 as millisecond

--select dateadd(hour, (@T / 1000000) % 100, dateadd(minute, (@T / 10000) % 100, dateadd(second, (@T / 100) % 100, dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))

--print (cast('00:00:00' as time(2)))
--*****************************************
--CREATE FUNCTION Psuka (@T int)
--	returns time(2)
--as
--	begin
--		declare @ter time;
--		set @ter = 	(select dateadd(hour, (@T / 1000000) % 100, dateadd(minute, (@T / 10000) % 100, dateadd(second, (@T / 100) % 100, dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2)))))))
--		return @ter
--	end
--go
--
--
--declare @Ta int
--set @Ta = 10455836
--print dbo.Psuka(@Ta)
--
--drop function dbo.Psuka


declare @T int
set @T = 20200228

--select (@T / 10000)%100 as year, (@T / 100)%100 as month, (@T / 1)%100 as day

--print (cast('' as date))
--print (cast('00:00:00' as time(2)))

--print dateadd(year, (@T / 10000) % 100, dateadd(month, (@T / 100) % 100, dateadd(day, (@T / 1) % 100, cast('YYYY-MM-DD' as date))))

declare @T int
set @T = 19971228
print convert(date, cast(@T as varchar))

print cast(getdate() as date)
