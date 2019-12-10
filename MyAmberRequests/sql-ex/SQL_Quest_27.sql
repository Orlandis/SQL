select p.maker, avg(PC.hd) from Product p join PC ON p.model = PC.model 
where p.maker in (select maker from Product as F_PR where type = 'PC' AND EXISTS 
(Select maker from Product where type = 'Printer' AND maker = F_PR.maker)) 
group by p.maker

