
--Получение итогов по колонке - использование ROLLUP в двух вариациях
SELECT CASE WHEN point IS NULL THEN 'ALL' ELSE CAST(point AS varchar) END point, 
SUM(inc) Qty
--FROM Income GROUP BY point WITH ROLLUP
FROM Income GROUP BY ROLLUP (point)
