-- INDEXES ON PRIMARY KEYS
create unique index person_idx on person(tax_code);
create unique index car_idx on car(license_plate);
create unique index owned_idx on owned(person, car);

-- INDEXES ON FOREIGN KEYS
create index car_owner on car(owner);
create index owned_person on owned(person);
create index owned_car on owned(car);