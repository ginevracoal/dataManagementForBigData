.open ../nycflights13.db

select 'JOIN:';
select ' ';

-- flights that flew with a plane manufactured by BOEING
select flights.id, flights.tailnum, planes.manufacturer
from flights, planes
where flights.tailnum = planes.tailnum and planes.manufacturer = "BOEING"
limit 10;
select ' ';

-- -- flights that flew to a destination with an altitude 
-- -- greater than 6000 feet sorted by altitude
-- select flights.id, flights.dest, airports.name, airports.alt
-- from flights, airports
-- where ___ and ___
-- having airports.alt > 6000
-- order by airports.alt
-- limit 10;
-- select ' ';

-- -- flights that took off with a plane with 4 engines and a visibility lower than 3 miles
-- select flights.id, planes.engines, weather.visib
-- from flights, weather, planes
-- where flights.time_hour = weather.time_hour and flights.origin = weather.origin 
--       and flights.tailnum = planes.tailnum and weather.visib < 3  and planes.engines = 4
-- limit 10

-- -- flight paths of length 2 (X --> Y --> Z)
-- select distinct f1.origin, f1.dest, f2.dest
-- from flights as f1, flights as f2
-- where f1.dest = f2.origin


-- -- flight paths of length 3 (X --> Y --> W --> Z)
-- select distinct f1.origin, f1.dest, f2.dest, f3.dest
-- from ___, ___, ___
-- where ___ and ___

-- -- flights that flew with a plane manufactured by BOEING
-- select flights.id, flights.tailnum, planes.manufacturer
-- from flights join planes on flights.tailnum = planes.tailnum
-- where planes.manufacturer = "BOEING"


select 'LEFT JOIN:';
select ' ';

-- -- flights and the corresponding plane manufactured, including flights that have no match in planes (there are some)
-- select flights.id, flights.tailnum, planes.manufacturer
-- from flights left join planes on flights.tailnum = planes.tailnum

-- -- inner count (only those with a match)
-- select count(*)
-- from flights join planes on flights.tailnum = planes.tailnum

-- -- outer count (all flights)
-- select count(*)
-- from flights left join planes on flights.tailnum = planes.tailnum

select 'RIGHT AND NULL JOINS:';
select ' ';

-- -- Right and full joins are not implemented in SQLite. 
-- -- However, they can be simulated using left join and 
-- -- union operators.

-- -- simulate a right join on planes and flights using left join
-- select  planes.manufacturer, flights.id, flights.tailnum
-- from planes right join flights on planes.tailnum = flights.tailnum 



-- -- simulate a full join on planes and flights using left join and union
-- select flights.id, flights.tailnum, planes.manufacturer
-- from flights full join planes on flights.tailnum = planes.tailnum

