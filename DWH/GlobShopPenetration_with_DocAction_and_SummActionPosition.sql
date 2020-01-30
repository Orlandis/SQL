use [WH]
--select * from wh.dbo.erp_ec_spec_doc_table where date_from_id = '20191205' and date_to_id = '20191218'
--select top 10 * from WH.dbo.fact_DocCash
declare @startDate int = 20200101
declare @endDate int = 20200129

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

--select top 5 * from fact_DocCash

select [fDC].[date_ID] date_ID, count(distinct check_num) count_all_checks, sum(SumWVAT) sum_all_checks into #GlobCountChecks from [wh].[dbo].[fact_DocCash] fDC
where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) --and fDC.node_ID = 299 --/////////////////////////////////////
group by fDC.date_ID order by fDC.date_ID

--Отобранное количество чеков по категориям акции --Временная таблица
select [fDC].[date_ID] datCheck, fDC.check_num, COUNT(distinct tovar_ID) kvo, sum(fDC.SumWVAT) SumActSku into #CustomCountChecks
from [wh].[dbo].[fact_DocCash] fDC where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) --and fDC.node_ID = 299 --/////////////////////////////////////
and tovar_ID in (select distinct tovar_id from cba.dbo.mtm_fb_prior where doc_id = 3102 and node_id = fDC.node_ID)
group by fDC.date_ID, fDC.check_num order by fDC.date_ID;

--select * from #GlobCountChecks
--select * from #CustomCountChecks

----Получение итоговых данных
----********************************************************************************************************
with Result1 as (select date_ID, count_all_checks, sum_all_checks from  #GlobCountChecks group by date_ID, count_all_checks, sum_all_checks),

Result2 as (select datCheck, count(kvo) onePosition, SUM(SumActSku) sum1 from #CustomCountChecks where kvo = 1 group by datCheck),

Result3 as (select Result1.*, onePosition, sum1 from Result1, Result2 where Result1.date_ID = Result2.datCheck),

Result4 as (select datCheck, count(kvo) morePosition, SUM(SumActSku) sum2 from #CustomCountChecks where kvo >= 2 group by datCheck),

Result5 as (select Result3.*, morePosition, sum2 from Result3, Result4 where Result3.date_ID = Result4.datCheck)

select date_ID Дата, count_all_checks Общее_количество_чеков, sum_all_checks Сумма_всех_чеков, (count_all_checks - (onePosition + morePosition)) Кво_чеков_с_0_входом, 
onePosition Кво_чеков_с_1_входом, morePosition 'Кво_чеков_с_входом > 2 позиций', (sum1+sum2) Сумма_проданных_акц_позиций, ((onePosition + morePosition) / cast(count_all_checks as float(5)))*100 '% Пенитрации'
from Result5 order by date_ID;


----********************************************************************************************************
----********************************************************************************************************
----********************************************************************************************************
