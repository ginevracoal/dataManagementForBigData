library(nycflights13)
library(dplyr)

flights %>% 
  count(year, month, day, sched_dep_time, flight, carrier) %>% 
  filter(n > 1)

# sort flights in chronological increasing order and then add to 
# the flights table an id attribute corresponding to the table 
# row number. Hence, each flight has a unique serial number
flights <- 
  flights %>% 
  arrange(year, month, day, sched_dep_time) %>%
  mutate(id = row_number()) %>% # adding id column
  select(id, everything())
head(flights)

# On the other hand, the other tables have key attributes:
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)
head(planes)

airports %>% 
  count(faa) %>% 
  filter(n > 1)
head(airports)

weather %>% 
  count(time_hour, origin) %>% 
  filter(n > 1)
head(weather)

# Unfortunately, some foreign key constraints are not satisfied 
# by our dataset:

# find rows violating FKC
flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)
# return all rows from flights where there are not matching values 
# for tailnums in planes, keeping just columns from flights.

# cure the violation of FKC 
# id_fk contains all the id's in flights with no matching values
id_fk = anti_join(flights, planes, by = "tailnum")$id

# set all tailnums corresponding to id_fk indexes to NA
flights = mutate(flights, tailnum = ifelse(id %in% id_fk, NA, tailnum))

# find rows violating FKC
# compare flights$dest to airports$faa
flights %>%
  anti_join(airports, by = c("dest" = "faa")) %>%
  count(dest, sort = TRUE)

# cure the violation of FKC
id_fk = anti_join(flights, airports, by = c("dest" = "faa"))$id
flights = mutate(flights, dest = ifelse(id %in% id_fk, NA, dest))

# set time zone of time_hour of weather 
library(lubridate)
tz(weather$time_hour) = "UTC"

flights %>%
  anti_join(weather, by = c("origin" = "origin", "time_hour" = "time_hour")) %>%
  count(time_hour, origin, sort = TRUE)


# We prefer not to cure the last violation by setting the foreign 
# keys to NA, since this would erase useful information from 
# flights (time and origin).

# EXPORT INTO CSV FILES

write.table(airlines, file = "airlines.csv", sep = ",", row.names=FALSE, col.names = FALSE, quote=FALSE, na="", qmethod = "double")

write.table(airports, file = "airports.csv", sep = ",", row.names=FALSE, col.names = FALSE, quote=FALSE, na="", qmethod = "double")

write.table(planes, file = "planes.csv", sep = ",", row.names=FALSE, col.names = FALSE, quote=FALSE, na="", qmethod = "double")

write.table(weather, file = "weather.csv", sep = ",", row.names=FALSE, col.names = FALSE, quote=FALSE, na="", qmethod = "double")

write.table(flights, file = "flights.csv", sep = ",", row.names=FALSE, col.names = FALSE, quote=FALSE, na="", qmethod = "double")


