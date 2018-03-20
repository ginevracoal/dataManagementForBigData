PRAGMA foreign_keys = ON;

-- violate primary key constraints
INSERT INTO PERSON VALUES ( 'FDGFGU78G23C271G', 'Steve', 'Hackett');

-- violate foreign key constraints
INSERT INTO CAR VALUES ('AG347HY', 'Punto', 'Fiat', 'black', 'null', '2018-03-20');



