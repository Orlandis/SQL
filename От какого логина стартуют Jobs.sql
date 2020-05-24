SELECT sv.name, sv.enabled FROM msdb.dbo.sysjobs_view sv 
	JOIN sys.server_principals sp ON sv.owner_sid = sp.sid
		WHERE sp.name = 'SQL\Admin'