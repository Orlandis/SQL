use Test
--SELECT onum, cname, Orders.cnum, Orders.snum
--FROM Salespeople, Customers, Orders
--WHERE Customers.city <> Salespeople.city
--AND Orders.cnum=Customers.cnum
--AND Orders.snum=Salespeople.snum
--
--select o.onum, s.sname, c.cname from Orders as o, Salespeople as s, Customers as c
--where o.cnum = c.cnum and o.snum = s.snum
--
--select c.cname, s.sname, s.comm from Salespeople as s, Customers as c, Orders
--where c.cnum = Orders.cnum and s.snum = Orders.snum and (s.comm*100) > 12
--
--select s.snum, sum(s.comm) from Salespeople as s, Orders
--where s.snum = Orders.snum and Orders.amt > 100
--group by s.snum