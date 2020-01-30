use [WH]
--select * from wh.dbo.erp_ec_spec_doc_table where date_from_id = '20191205' and date_to_id = '20191218'
--select top 10 * from WH.dbo.fact_DocCash
declare @startDate int = 20191128
declare @endDate int = 20200108

IF OBJECT_ID(N'tempdb..#CustomCountChecks', N'U') IS NOT NULL
DROP TABLE #CustomCountChecks
IF OBJECT_ID(N'tempdb..#GlobCountChecks', N'U') IS NOT NULL
DROP TABLE #GlobCountChecks
IF OBJECT_ID(N'tempdb..#SKUInto', N'U') IS NOT NULL
DROP TABLE #SKUInto
--**********************************
--create table #SKUInto (sku int)
--insert into #SKUInto values (),(),()
--**********************************

--Общее количество чеков --Временная таблица

select [fDC].[date_ID] date_ID, count(distinct check_num) count_all_checks into #GlobCountChecks from [wh].[dbo].[fact_DocCash] fDC
where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) --and fDC.node_ID = 299 --/////////////////////////////////////
group by fDC.date_ID order by fDC.date_ID
--

--Отобранное количество чеков по категориям акции --Временная таблица
select [fDC].[date_ID] datCheck, COUNT(distinct tovar_ID) kvo into #CustomCountChecks
from [wh].[dbo].[fact_DocCash] fDC where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) --and fDC.node_ID = 299 --/////////////////////////////////////
and tovar_ID in (select distinct tovar_id from cba.dbo.mtm_fb_prior where doc_id = 3102 and node_id = fDC.node_ID)
group by fDC.date_ID, fDC.check_num order by fDC.date_ID;
--
--select * from #GlobCountChecks
--select * from #CustomCountChecks


----Получение итоговых данных
----********************************************************************************************************
with Result1 as (select date_ID, count_all_checks from  #GlobCountChecks group by date_ID, count_all_checks),

Result2 as (select datCheck, count(kvo) onePosition from #CustomCountChecks where kvo = 1 group by datCheck),

Result3 as (select Result1.*, onePosition from Result1, Result2 where Result1.date_ID = Result2.datCheck),

Result4 as (select datCheck, count(kvo) morePosition from #CustomCountChecks where kvo >= 2 group by datCheck),

Result5 as (select Result3.*, morePosition from Result3, Result4 where Result3.date_ID = Result4.datCheck)

select date_ID, count_all_checks, (count_all_checks - (onePosition + morePosition)) ZERO, 
onePosition, morePosition as '>2' , ((onePosition + morePosition) / cast(count_all_checks as float))*100
from Result5 order by date_ID;

----********************************************************************************************************
----********************************************************************************************************
----********************************************************************************************************
