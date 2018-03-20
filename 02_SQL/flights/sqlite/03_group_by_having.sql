.open nycflights13.db

-- 	GROUP BY AND HAVING
select 'GROUP BY AND HAVING:';
select ' ';

--- count tuples of planes
select count(*)
from planes;
select ' ';

--- count number of not null values for attribute 
-- manufacturer in table planes
select count(manufacturer)
from planes;
select ' ';

--- count number of distinct, not null values for 
-- attribute manufacturer in table planes
select count(distinct manufacturer)
from planes;
select ' ';

--- summary of seats of planes
select max(seats), min(seats), sum(seats), avg(seats), sum(seats) / count(seats)
from planes;
select ' ';

-- the number of flights per destination
select dest, count(*) as count
from flights
group by dest
limit 10;
select ' ';

-- the top ten destination by number of flights
select dest, count(dest) as count
from flights
group by dest
order by count desc
limit 10;
select ' ';

-- -- the number of flights per month and day sorted in 
-- -- decreasing order
-- select month, day, count(*) as count
-- from flights
-- group by month, day
-- order by count desc
-- limit 10;
-- select ' ';

-- -- the mean departure delay per month and day sorted 
-- -- in decreasing order
-- select dep_delay, count(month) as count_month, count(day) as count_day 
-- from ___
-- group by 
-- order by ___

-- the busy days (those with more than 1000 flights)
select month, day, count(*) as count
from flights
group by month, day
having count > 1000
order by count desc
limit 20;
select ' ';

-- -- the popular destinations (those with more than 1000 
-- flights) sorted by number of flights in descending 
-- order
select dest, count(*) as count
from flights
group by dest
having count > 1000
order by count desc
limit 15;
select ' ';

-- -- the mean departure delay per day sorted in decreasing 
-- -- order of all flights on busy days (those with more 
-- -- than 1000 flights) of July 
-- select day, count(*) as count, round(avg(dep_delay), 2) as delay
-- from ___
-- where ___
-- group by ___
-- having ___
-- order by ___