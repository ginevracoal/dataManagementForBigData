.open ../nycflights13.db

-- ORDER BY
select 'ORDER BY:';
select ' ';

-- id and departure delay of flights that have a positive
-- departure delay sorted by delay departure in decreasing 
-- order

select id, dep_delay
from flights 
where (dep_delay > 0)
order by dep_delay asc
limit 10;
select ' ';

-- id, departure and arrival delays, and catch up of 
-- flights that catched up during the flight sorted by 
-- catch up time in decreasing order
select id, dep_delay, arr_delay, (arr_delay - dep_delay) as catchup
from flights
where catchup is not null
order by catchup desc
limit 10;
select ' ';