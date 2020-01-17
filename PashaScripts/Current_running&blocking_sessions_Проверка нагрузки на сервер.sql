SELECT r.session_id AS [victim SPID],
r.blocking_session_id,
DB_NAME(r.database_id) AS Database_Name,
s.host_name,
s.login_name AS [victim login name],
r.status as [victim status],
r.command,
r.cpu_time,
r.total_elapsed_time /1000 AS [Wait time, sec],
t.text as Query_Text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
WHERE r.blocking_session_id <> 0
GO 

SELECT * FROM sys.dm_exec_query_memory_grants d ORDER BY requested_memory_kb DESC
GO

--SELECT r.session_id
--ion_id,
--DB_NAME(r.database_id) AS Database_Name,
--s.host_name,
--s.login_name,
--s.original_login_name,
--r.status,
--r.command,
--r.cpu_time,
--r.total_elapsed_time,
--t.text as Query_Text
--FROM sys.dm_exec_requests r
--CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
--INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id 
--WHERE t.text != 'sp_server_diagnostics' --ѕроверка доступности кластера, всегда работает
----ORDER BY r.cpu_time DESC
--GO  
 
IF OBJECT_ID('master.dbo.sp_whoisactive') IS NOT NULL
exec master.dbo.sp_whoisactive --@get_plans = 1 --@show_system_spids = 1 --@filter_type = 'database', @filter = 'ERP', @get_additional_info = 1
ELSE SELECT 'Cannot find stored procedure master.dbo.sp_whoisactive'
GO

--kill 156
--sp_who2 110
--dbcc opentran ('EkoUPPwork') 

