--SELECT * FROM [PPC_market_m24].[dbo].[Session] where bp_id = 3 ORDER by date_start DESC
--SELECT * FROM [PPC_market_m24].[dbo].[ScanData] where session_id = 482
--SELECT * FROM [PPC_market_m24].[dbo].[ScanData] where session_id = 481 and event_date > '20191213'

USE [PPC_market_m24]
GO

DECLARE @ppc_id nvarchar(4000)
DECLARE @session_id int
DECLARE @bp_id int

EXECUTE [dbo].[spInventoryUploadDocs] 
   @ppc_id = '30303038-3030333131303337303032323200'
  ,@session_id = 481
  ,@bp_id = 3

  