use WH;

IF OBJECT_ID(N'tempdb..#timeOfChecks', N'U') IS NOT NULL
DROP TABLE #timeOfChecks

declare @OpenTime time;
declare @CloseTime time;

select date_ID, node_id, kassa_ID, check_num, count(distinct(tovar_ID)) Count_SKU,
	cast(Time_open_ID as varchar) Time_open_ID, 
	cast(Seconds_open_id as varchar) Seconds_open_id, 
	cast(Time_close_ID as varchar) Time_close_ID, 
	cast(Seconds_close_id as varchar) Seconds_close_id
			into #timeOfChecks from dbo.fact_DocCash 
				where date_ID = 20200120 AND oper_type_ID in (150401,150404) and node_ID = 2 --and check_num in (816306,816309)
	group by date_ID, node_id, kassa_ID, check_num, Time_open_ID, Seconds_open_id, Time_close_ID, Seconds_close_id
	order by date_ID, node_id, kassa_ID, check_num

--select * from #timeOfChecks
--select top 10 * from dbo.fact_DocCash where date_ID = 20200120 AND oper_type_ID in (150401,150404) and node_ID = 2

select date_ID, node_id, kassa_ID, check_num, Count_SKU,
			cast ((case when len(Time_open_ID) = 1 then REPLACE(Time_open_ID, Time_open_ID,'00:0'+Time_open_ID) 
			when len(Time_open_ID) = 2 then REPLACE(Time_open_ID, Time_open_ID,'00:'+Time_open_ID) 
			when len(Time_open_ID) = 3 then REPLACE(Time_open_ID, Time_open_ID, '0'+SUBSTRING(Time_open_ID,1,1)+':'+substring(Time_open_ID,2,2)) 
			when len(Time_open_ID) = 4 then REPLACE(Time_open_ID, Time_open_ID, SUBSTRING(Time_open_ID,1,2)+':'+substring(Time_open_ID,3,4)) 
			end) + 
			(case when len(Seconds_open_id) = 1 then REPLACE(Seconds_open_id, Seconds_open_id,':0'+Seconds_open_id) 
			when len(Seconds_open_id) = 2 then REPLACE(Seconds_open_id, Seconds_open_id,':'+Seconds_open_id) end) as time(0)) [OpenTime],  
			
			cast ((case when len(Time_close_ID) = 1 then REPLACE(Time_close_ID, Time_close_ID,'00:0'+Time_close_ID) 
			when len(Time_close_ID) = 2 then REPLACE(Time_close_ID, Time_close_ID,'00:'+Time_close_ID) 
			when len(Time_close_ID) = 3 then REPLACE(Time_close_ID, Time_close_ID, '0'+SUBSTRING(Time_close_ID,1,1)+':'+substring(Time_close_ID,2,2)) 
			when len(Time_close_ID) = 4 then REPLACE(Time_close_ID, Time_close_ID, SUBSTRING(Time_close_ID,1,2)+':'+substring(Time_close_ID,3,4)) 
			end) + 
			(case when len(Seconds_close_id) = 1 then REPLACE(Seconds_close_id, Seconds_close_id,':0'+Seconds_close_id) 
			when len(Seconds_close_id) = 2 then REPLACE(Seconds_close_id, Seconds_close_id,':'+Seconds_close_id) end) as time(0)) AS [CloseTime],

			DATEDIFF(ss,
						cast ((case when len(Time_open_ID) = 1 then REPLACE(Time_open_ID, Time_open_ID,'00:0'+Time_open_ID) 
			when len(Time_open_ID) = 2 then REPLACE(Time_open_ID, Time_open_ID,'00:'+Time_open_ID) 
			when len(Time_open_ID) = 3 then REPLACE(Time_open_ID, Time_open_ID, '0'+SUBSTRING(Time_open_ID,1,1)+':'+substring(Time_open_ID,2,2)) 
			when len(Time_open_ID) = 4 then REPLACE(Time_open_ID, Time_open_ID, SUBSTRING(Time_open_ID,1,2)+':'+substring(Time_open_ID,3,4)) 
			end) + 
			(case when len(Seconds_open_id) = 1 then REPLACE(Seconds_open_id, Seconds_open_id,':0'+Seconds_open_id) 
			when len(Seconds_open_id) = 2 then REPLACE(Seconds_open_id, Seconds_open_id,':'+Seconds_open_id) end) as time(0)),
			cast ((case when len(Time_close_ID) = 1 then REPLACE(Time_close_ID, Time_close_ID,'00:0'+Time_close_ID) 
			when len(Time_close_ID) = 2 then REPLACE(Time_close_ID, Time_close_ID,'00:'+Time_close_ID) 
			when len(Time_close_ID) = 3 then REPLACE(Time_close_ID, Time_close_ID, '0'+SUBSTRING(Time_close_ID,1,1)+':'+substring(Time_close_ID,2,2)) 
			when len(Time_close_ID) = 4 then REPLACE(Time_close_ID, Time_close_ID, SUBSTRING(Time_close_ID,1,2)+':'+substring(Time_close_ID,3,4)) 
			end) + 
			(case when len(Seconds_close_id) = 1 then REPLACE(Seconds_close_id, Seconds_close_id,':0'+Seconds_close_id) 
			when len(Seconds_close_id) = 2 then REPLACE(Seconds_close_id, Seconds_close_id,':'+Seconds_close_id) end) as time(0))) TimeDifferSecons

				from #timeOfChecks 
			




