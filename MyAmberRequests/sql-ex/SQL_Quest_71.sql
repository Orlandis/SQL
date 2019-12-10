use [sql-ex]
select [maker] from [Product] left join [PC] on Product.model = PC.model
where Product.type = 'PC'
group by maker
HAVING count(Product.model) = count(PC.model)