--select * from Customers
select city, count(*) from Test5 group by city having count(*)>1
select id, city from Test5

alter table Test5 modify (id identity(1,1))
alter table Test5 drop column id
alter table Test5 add id int identity(1,1) primary key
--select * into Test5 from Customers
--drop table Test5
--select * from Test5