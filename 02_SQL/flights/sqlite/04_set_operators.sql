.open ../nycflights13.db

-- 	SET OPERATORS
select 'SET OPERATORS:';
select ' ';

-- airports that are either origins or destinations 
-- (without duplicates)
select origin
from flights
union
select dest
from flights
limit 10;
select ' ';

-- airports that are either origins or destinations 
-- (with duplicates)
select origin
from flights
union all
select dest
from flights
limit 10;
select ' ';
  
-- airports that are both origins and destinations
select origin
from flights
intersect
select dest
from flights
limit 10;
select ' ';

-- airports that are either origins but not destinations
select origin
from flights
except
select dest
from flights
limit 10;
select ' ';