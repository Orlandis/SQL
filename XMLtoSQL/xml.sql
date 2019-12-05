--****** FIRST STEP ******-- 
drop TABLE XMLtoSQL
create table XMLtoSQL (id varchar(100), author varchar(100), title VARCHAR(100), genre VARCHAR(100), 
price varchar(100), publish_date varchar(100), description VARCHAR(100));
--****** SECOND STEP ******-- 
Declare @xml XML
Select  @xml  = CONVERT(XML,bulkcolumn,2) FROM OPENROWSET(BULK 'E:\Test\books.xml',SINGLE_BLOB) AS X
SET ARITHABORT ON
	Insert into [XMLtoSQL] (id, author, title, genre, price, publish_date, [description])
select 
	REPLACE(P.value('@id[1]','VARCHAR(100)'),'bk','') AS id,
	P.value('author[1]','VARCHAR(100)') AS author,
	P.value('title[1]','VARCHAR(100)') AS title,
	P.value('genre[1]','VARCHAR(100)') AS genre,
	P.value('price[1]','VARCHAR(100)') AS price,
	P.value('publish_date[1]','VARCHAR(100)') AS publish_date,
	P.value('description[1]','VARCHAR(100)') AS [description]
From @xml.nodes('/catalog/book') PropertyFeed(P);
--****** THIRD STEP ******-- 
alter table XMLtoSQL alter column price DECIMAL(5,2)
alter table XMLtoSQL alter column publish_date DATE
alter table XMLtoSQL alter column id INT not null
--****** VIEW RESULT ***************---
select * from XMLtoSQL order BY id
