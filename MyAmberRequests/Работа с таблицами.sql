use Test

--**************** �������� ������� ****************************--

--create table Salespeople (snum int, sname char(10), city char(10), comm decimal(5,2))
--create table Customers (cnum int, cname char(10), city char(10), rating int, snum int)
--create table Orders (onum int, amt dec, odate date, cnum int, snum int)

--**************** ���������� ������ � ������� ****************************--

insert into Orders values(3011 , 9891.88 , '10.06.1990', 2006 , 1001)

--**************** �������� ������ �� ������� ****************************--

delete from Orders where onum = 3011

--**************** �������� ������� ****************************--
drop table Salespeople

--**************** ��������� ���� ������� ****************************--
alter table Orders alter column amt dec(6,2)

--exec sp_spaceused N'Customers' 
--exec sp_spaceused

select COUNT (distinct snum) from Orders
select COUNT (snum) from Orders
select COUNT (*) from Customers
select distinct * from Orders
select * from Orders