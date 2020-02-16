-- Все имена для колонок PIVOT в одной строке

select STUFF((SELECT ',' + '['+[Name]+']'
  FROM [AdventureWorks2016].[Production].[Location]
  for XML PATH('')),1,1,'')