.open ../DB/nycflights13.db

-- WHERE
select 'WHERE:';
select ' ';

-- flights on Christmas
select *
from flights 
where day is 25 and month is 12
limit 10;
select ' ';

-- id, departure delay and arrival delay of flights 
-- that have either a null departure delay or a null 
-- arrival delay
select id, dep_delay, arr_delay
from flights 
where dep_delay is null or arr_delay is null
limit 10;
select ' ';

-- id, departure time and arrival time of flights that 
-- have a not null departure time and a not null arrival 
-- time. 
-- First version using is not null
select id, dep_time, arr_time
from flights 
where dep_time is not null and arr_time is not null
limit 10;
select ' ';

-- Second version using not()
select id, dep_time, arr_time
from flights 
where not(dep_time is null or arr_time is null)
limit 10;
select ' ';

-- planes with tailnum that starts with N
select *
from planes
where tailnum like 'N_%'
limit 10;
select ' ';

-- planes with tailnum that starts with N10
select *
from planes
where tailnum like 'N10_%'
limit 10;
select ' ';
