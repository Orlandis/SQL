EXEC UserBackUp @BackupType = 'FULL'

SELECT name, state, state_desc from sys.databases 