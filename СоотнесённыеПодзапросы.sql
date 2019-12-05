-- яннрмеяеммше ондгюопняш
-- гЮДЮВЮ ╧1
use Test
select a.cnum, a.cname from Customers a where rating = (select max(b.rating) from Customers b where a.city = b.city)

