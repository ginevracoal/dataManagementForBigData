
CREATE TABLE person (
	tax_code text(16), 
	name text NOT NULL, 
	surname text NOT NULL,
	primary key (tax_code)
);

CREATE TABLE car (
	license_plate text(7), 
	model text, 
	brand text, 
	color text, 
	owner text, 
	date text,
	primary key (license_plate),
	foreign key (owner) references person(tax_code)
); 

CREATE TABLE owned (
	person text, 
	car text, 
	start_date text, 
	end_date text,
	primary key (person, car),
	foreign key (person) references person (tax_code),
	foreign key (car) references car(license_plate)
); 