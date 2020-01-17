use [sql-ex]
--select * from Outcomes 
--select * from Classes order by class


select class from Ships group by class having count(*) >=3

select class, count(*) from Ships join Outcomes ON Ships.name = Outcomes.ship 
where class in (select class from Ships group by class 
having count(class) >=3) AND Outcomes.result = 'sunk' group by class


SELECT class, COUNT(result) AS sunk FROM (SELECT class, result, name FROM Ships LEFT JOIN 
Outcomes ON ship=name AND ULL AND  result = 'sunk') T 
GROUP BY class 
HAVING COUNT(class) > 2 AND count(result) > 0
 

