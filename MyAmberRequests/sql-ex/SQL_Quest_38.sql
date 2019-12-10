select distinct country from Classes cl where 
type = 'bb' and EXISTS (select type from Classes where type = 'bc' and country = cl.country)
