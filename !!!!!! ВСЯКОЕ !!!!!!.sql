use AdventureWorks2014
set language English
set dateformat dmy
print getdate()

select * from sys.syslanguages order by alias



update top(1) dbo.DatabaseLog
SET PostTime = '20140716 12:12:12'
select COUNT(*) from dbo.DatabaseLog where CAST(PostTime as Date) = '20140716'
select * from dbo.DatabaseLog order by PostTime


select EOMONTH(GETDATE())

 
GO

ALTER TABLE dbo.DatabaseLog
ADD MonthLastDay AS EOMONTH(PostTime) --PERSISTED
GO

--CREATE INDEX IX_MonthLastDay ON dbo.DatabaseLog (MonthLastDay)

select COL_LENGTH('dbo.DatabaseLog', 'PostDatabaseUser')

use Sasha
select COL_NAME(OBJECT_ID('dbo.UserTypes'), 2)

--///////////////////////////////////////////////////////
--create database Test1 collate Latin1_General_100_CI_AS
use Test1
DECLARE @a NCHAR(1) = 'À', @b NCHAR(1) = 'Ó'

SELECT @a, @b
WHERE @a = @b
--///////////////////////////////////////////////////////
