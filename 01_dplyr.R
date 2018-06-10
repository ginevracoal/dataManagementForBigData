# Run the queries with respect to the dataset nycflights13. 
# Before querying, add an surrogate key called id to the data frame flights.
library(nycflights13)
library(dplyr)
glimpse(flights)

# aggiungo al dataframe l'id
flights = mutate(flights, id = row_number() %>% 
                   select(id, everything()))

# flights on Christmas
filter(flights, month==12 & day==25)
subset(flights, month==12 & day==25)

# flights that have a delay (either on departure or on arrival)
filter(flights, !is.na(dep_delay) | !is.na(arr_delay))
subset(flights, !is.na(dep_delay) | !is.na(arr_delay))

# flights that were not cancelled (that is, those with valid 
# departure and arrival times)
filter(flights, !is.na(dep_time) & !is.na(arr_time))
subset(flights, !is.na(dep_time) & !is.na(arr_time))

# flights that have a departure delay sorted by delay
filter(flights, dep_delay > 0) %>% 
  arrange(desc(dep_delay))

# flights that catched up during the flight sorted by catch 
# up time
flights %>% 
  mutate(catchup = dep_delay - arr_delay) %>% 
  select(id, dep_delay, arr_delay, catchup) %>% 
  filter(catchup > 0) %>% 
  arrange(desc(catchup))

# the number of flights per day
flights %>% 
  group_by(month, day) %>% 
  summarise(count = n()) 
# or
count(flights, month, day)

# the busy days (with more than 1000 flights)
flights %>% 
  group_by(month, day) %>% 
  summarise(count = n()) %>% 
  filter(count > 1000)

# the number of flights per destination
flights %>% 
  group_by(dest) %>% 
  summarise(count = n())
# or
count(flights, dest)
  
# the popular destinations (with more than 365 flights) sorted
# by number of flights in descending order
flights %>% 
  group_by(dest) %>% 
  summarise(count = n()) %>% 
  filter(count > 365) %>% 
  arrange(desc(count))
  
# the mean departure delay per day sorted in decreasing order 
# of all flights on busy days of summer 
flights %>% 
  filter(month  %in% 6:8) %>% 
  group_by(month, day) %>% 
  summarise(n = n(), avg_delay = mean(dep_delay, na.rm=TRUE)) %>% 
  filter(n > 1000) %>% 
  arrange(desc(avg_delay))

glimpse(planes)
# flights that flew with a plane manufactured by BOEING
planes %>% 
  left_join(flights, by="tailnum") %>% 
  filter(manufacturer == "BOEING") %>% 
  select(id, tailnum, manufacturer)

# flights that flew to a destination with an altitude greater 
# than 6000 feet sorted by altitude
airports %>% 
  left_join(flights, by = c("faa"="dest")) %>% 
  filter(alt > 6000) %>% 
  select(id, faa, alt) %>% 
  arrange(alt)

# flights that took off with a plane with 4 engines and a 
# visibility lower than 3 miles
weather %>% 
  left_join(flights) %>% 
  left_join(planes, by="tailnum") %>% 
  filter(engines == 4 & visib < 3) %>% 
  select(id, engines, visib) 

# flights with destination and origin airports with an altitude 
# difference of more than 6000 feet
flights %>%
  left_join(airports, by=c("origin"="faa")) %>%
  left_join(planes, by=c("dest"="faa")) %>%
  filter() %>%
  select(id, engines, visib)
# questo è da completare!

