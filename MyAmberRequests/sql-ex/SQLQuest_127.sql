
select CAST(AVG(price) as dec(5,2)) rice from 

(select MIN(price) price from Laptop l where price is not null and l.model in  
(SELECT lap_product.model FROM Product AS lap_product WHERE type = 'laptop' AND 
EXISTS (SELECT model FROM Product WHERE type = 'PC' AND model in (select model from PC where speed = (select min(speed) from PC)) AND maker = lap_product.maker)) 

UNION 

(select MAX(price) price from PC p where price is not null and p.model in  
(SELECT model FROM Product AS pcp WHERE type = 'PC' AND 
EXISTS (SELECT model FROM Product WHERE type = 'Printer' AND model in (select model from Printer where price = (select min(price) from Printer)) AND maker = pcp.maker)))

UNION 

(select MAX(price) price from Printer prn where price is not null and prn.model in  
(SELECT model FROM Product AS pr WHERE type = 'Printer' AND 
EXISTS (SELECT model FROM Product WHERE type = 'Laptop' AND model in (select model from Laptop where ram = (select max(ram) from Laptop)) AND maker = pr.maker)))) as test
