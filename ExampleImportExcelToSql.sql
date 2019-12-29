//Инструкция по импорту данных с Excel в SQL
//Необходимо выполнить подготовительное действие 
//На ПК, где производится импорт, должен быть офис
//-----------------
//Перед выполнением распределенного запроса по импорту, необходимо включить параметр ad hoc distributed queries в 
//конфигурации сервера.
//Это связано с тем, что по умолчанию SQL Server не разрешает нерегламентированные распределенные запросы, использующие 
//операторы OPENROWSET и OPENDATASOURCE. 
//Если этот параметр равен 1, SQL Server допускает выполнение нерегламентированных распределенных запросов.
//В нерегламентированных распределенных запросах с помощью функций OPENROWSET и OPENDATASOURCE осуществляется 
//подключение к удаленным источникам данных, использующим OLE DB. 
//Функции OPENROWSET и OPENDATASOURCE должны использоваться с теми источниками данных OLE DB, обращения к которым происходят нечасто. 
//Для источников данных, к которым обращение производится более чем несколько раз, определите связанный сервер.

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

USE Test;

SELECT * INTO ImportToSql
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
'Excel 12.0; Database=C:\Install\podr.xlsx', [TDSheet$]);

SELECT * FROM ImportToSql

UPDATE ImportToSql SET Prefix = REPLACE(prefix, prefix, prefix + 'MAX2008')
--drop table ImportToSql