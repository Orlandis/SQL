use [WH]
--select * from wh.dbo.erp_ec_spec_doc_table where date_from_id = '20191205' and date_to_id = '20191218'
--select top 10 * from WH.dbo.fact_DocCash
declare @startDate int = 20191223
declare @endDate int = 20191225

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
--create table #GlobCountChecks (dateBuy int, node int, nameShop varchar(255), kasID smallInt, count_position Int)
create table #GlobCountChecks (node int, nameShop varchar(255), count_position Int)

insert into #GlobCountChecks
--select [fDC].[date_ID], [fDC].[node_ID], [dn].[name], [fDC].[kassa_ID], count(distinct check_num) count_all_checks 
select [fDC].[node_ID], [dn].[name], count(distinct check_num) count_all_checks 
from [wh].[dbo].[fact_DocCash] fDC join [dbo].[dim_node] dn on [fDC].[node_ID] = [dn].[node_ID] 
where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) and fDC.node_ID = 299
--------and tovar_ID in (select tovar_ID from wh.dbo.erp_ec_spec_doc_table where fDC.node_ID = node_id and fDC.date_ID between date_from_id and date_to_id)
group by fDC.node_ID, dn.name order by fDC.node_ID, dn.name



--Отобранное количество чеков по категориям акции --Временная таблица
create table #CustomCountChecks (node int, nameShop varchar(255), count_position smallInt)
insert into #CustomCountChecks 
select [fDC].[node_ID], [dn].[name], COUNT(tovar_ID)
from [wh].[dbo].[fact_DocCash] fDC join [dbo].[dim_node] dn on [fDC].[node_ID] = [dn].[node_ID] 
where [fDC].[date_ID] Between @startDate AND @endDate and [oper_type_ID] in (150401,150404) and fDC.node_ID = 299
--and tovar_ID in (select tovar_ID from wh.dbo.erp_ec_spec_doc_table erc where erc.node_id = fDC.node_ID and erc.date_from_id >= @startDate and erc.date_to_id <= @endDate)
--and tovar_ID in (select sku from #SKUInto)
and tovar_ID in (select distinct tovar_id from cba.dbo.mtm_fb_prior where doc_id = 3102 and node_id = fDC.node_ID)
group by fDC.node_ID, dn.name, fDC.check_num order by fDC.node_ID, dn.name;

--select * from #SKUInto
--  Залилось

--Получение итоговых данных
--select dateBuy, node, nameShop, kasID, count_position from  #GlobCountChecks
--group by dateBuy, node, nameShop, kasID, count_position order by node, nameShop, kasID, dateBuy;
--
--select dateBuy, node, nameShop, kasID, count(count_position) onePosition from #CustomCountChecks
--where count_position = 1
--group by dateBuy, node, nameShop, kasID order by node, nameShop, kasID, dateBuy;
--
--select dateBuy, node, nameShop, kasID, count(count_position) morePosition from #CustomCountChecks
--where count_position >= 2
--group by dateBuy, node, nameShop, kasID order by node, nameShop, kasID, dateBuy;
--********************************************************************************************************
with Result1 as (select node, nameShop, count_position from  #GlobCountChecks
group by node, nameShop, count_position),

Result2 as (select node, nameShop, count(count_position) onePosition from #CustomCountChecks
where count_position = 1 group by node, nameShop),

Result3 as (select Result1.*, onePosition from Result1, Result2 where Result1.node = Result2.node),

Result4 as (select node, nameShop, count(count_position) morePosition from #CustomCountChecks
where count_position >= 2 group by node, nameShop),

Result5 as (select Result3.*, morePosition from Result3, Result4 where Result3.node = Result4.node)

select node, nameShop, count_position, (count_position - (onePosition + morePosition)) ZERO, 
onePosition, morePosition as '>2' , ((onePosition + morePosition) / cast(count_position as float))*100
from Result5 order by node, nameShop;









