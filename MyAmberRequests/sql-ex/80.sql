use [sql-ex]
select * from Product where type = 'PC' order by maker

select maker from Product where model in (select model from PC union select model from Laptop group by model) group by maker

select * from Product where type = 'PC' order by maker
select * from PC

