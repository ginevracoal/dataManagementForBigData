
CREATE TABLE airlines ( 
 carrier VARCHAR(2), 
 name VARCHAR(60),
 primary key (carrier)
);

CREATE TABLE airports ( 
 faa VARCHAR(3),
 name VARCHAR(60),
 lat REAL,
 lon REAL,
 alt INTEGER,
 tz INTEGER,
 dst VARCHAR(1),
 tzone VARCHAR(60),
 primary key (faa)
);

CREATE TABLE planes ( 
 tailnum VARCHAR(10),
 year INTEGER,
 type VARCHAR(30),
 manufacturer VARCHAR(30),
 model VARCHAR(30),
 engines INTEGER,
 seats INTEGER,
 speed INTEGER,
 engine VARCHAR(30),
 primary key (tailnum)
);


CREATE TABLE weather ( 
 origin VARCHAR(3),
 year INTEGER,
 month INTEGER,
 day INTEGER,
 hour INTEGER,
 temp REAL,
 dewp REAL,
 humid REAL,
 wind_dir REAL,
 wind_speed REAL,
 wind_gust REAL,
 precip REAL,
 pressure REAL,
 visib REAL,
 time_hour REAL,
 primary key (time_hour, origin),
 foreign key (origin) references airports(faa)
);

CREATE TABLE flights ( 
 id BIGINT, -- big integer
 year INTEGER,
 month INTEGER,
 day INTEGER,
 dep_time INTEGER,
 sched_dep_time INTEGER,
 dep_delay INTEGER,
 arr_time INTEGER,
 sched_arr_time INTEGER,
 arr_delay INTEGER,
 carrier VARCHAR(2), 
 flight INTEGER,
 tailnum VARCHAR(10), 
 origin VARCHAR(3), 
 dest VARCHAR(3), 
 air_time INTEGER,
 distance INTEGER,
 hour INTEGER,
 minute INTEGER,
 time_hour REAL,
 primary key (id),
 foreign key (carrier) references airlines(carrier),
 foreign key (tailnum) references planes(tailnum),
 foreign key (origin) references airports(faa),
 foreign key (dest) references airports(faa)
 -- this is not satisfied by the dataset
 --foreign key (time_hour, origin) references weather(time_hour, origin)
);
