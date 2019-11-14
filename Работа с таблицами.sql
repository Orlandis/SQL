use Test

--**************** СОЗДАНИЕ ТАБЛИЦЫ ****************************--

--create table Salespeople (snum int, sname char(10), city char(10), comm decimal(5,2))
--create table Customers (cnum int, cname char(10), city char(10), rating int, snum int)
--create table Orders (onum int, amt dec, odate date, cnum int, snum int)

--**************** Добавление записи в таблицу ****************************--

insert into Orders values(3011 , 9891.88 , '10.06.1990', 2006 , 1001)

--**************** Удаление записи из таблицы ****************************--

delete from Orders where onum = 3002

--**************** Удаление таблицы ****************************--
drop table Salespeople

--**************** ИЗМЕНЕНИЕ ТИПА КОЛОНКИ ****************************--
alter table Orders alter column amt dec(6,2)

--use Test
exec sp_spaceused N'Customers' 
--exec sp_spaceused