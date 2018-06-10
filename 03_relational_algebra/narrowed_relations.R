library(nycflights13)
library(dplyr)

# Find the flight number, the plane tail number, and plane manufacturer of 
# flights manufactured by EMBRAER.

planesNarrow = planes %>% select(tailnum, manufacturer) 
flightsNarrow = flights %>% select(flight, tailnum, origin, dest)

first_selection = flightsNarrow %>% select(flight, tailnum) %>% 
  full_join(select(planesNarrow, tailnum, manufacturer))

first_selection %>% filter(manufacturer == 'EMBRAER')

# Find the flight paths of length 2 (X –> Y –> Z).
# Find the flight paths of length 3 (X –> Y –> W –> Z).

flightsNarrow = flights %>% select(origin, dest)

select(flights, X = origin, Y = dest) %>% 
  inner_join(select(flights, Y = origin, Z = dest)) %>% 
  distinct()
            
select(flights, X = origin, Y = dest) %>% 
  inner_join(select(flights, Y = origin, W = dest)) %>% 
  inner_join(select(flights, W = origin, Z = dest)) %>% 
  distinct()
