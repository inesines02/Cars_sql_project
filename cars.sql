CREATE DATABASE cars;
USE cars;

CREATE TABLE person (
    Person_id INT PRIMARY KEY,
    last_name VARCHAR(20), 
    first_name VARCHAR(20), 
    Email VARCHAR(50) UNIQUE,
    Phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE models (
    model_id VARCHAR(20) PRIMARY KEY,
    model VARCHAR(20),
    Brand VARCHAR(20),
    Power VARCHAR(20)
);

ALTER TABLE models 
ADD CONSTRAINT ch_puiss CHECK (Power IN ('4CH', '5CH', '6CH'));

CREATE TABLE CARS (
    Registration_id VARCHAR(20) PRIMARY KEY,
    model_id VARCHAR(20) NOT NULL,
    dateofcirculation DATE NOT NULL,
    Mileage NUMERIC, 
    requested_price NUMERIC NOT NULL,
    CONSTRAINT fk_CARS FOREIGN KEY (model_id) REFERENCES models(model_id)
);

CREATE TABLE acquisitions (
    Registration_id VARCHAR(20) NOT NULL,
    Person_id INT NOT NULL,
    start_date DATE,
    end_date DATE, 
    CONSTRAINT fk1_acq FOREIGN KEY (Registration_id) REFERENCES CARS(Registration_id),
    CONSTRAINT fk2_acq FOREIGN KEY (Person_id) REFERENCES person(Person_id),
    CONSTRAINT pk_acq PRIMARY KEY (Registration_id, Person_id)
);

CREATE TABLE CONTRACTofSALE (
    contract_id VARCHAR(20), 
    Person_id INT NOT NULL,
    Registration_id VARCHAR(20) NOT NULL,
    date_sale DATE DEFAULT CONVERT(date, GETDATE()),
    price_sale INT NOT NULL,
    CONSTRAINT fk_contract FOREIGN KEY (Registration_id, Person_id) REFERENCES acquisitions(Registration_id, Person_id),
    CONSTRAINT pk_contract PRIMARY KEY (contract_id)
);


INSERT INTO models VALUES ('RC','Clio', 'Renault','5CH');
INSERT INTO models VALUES ('PCC','206cc', 'Peugeot','5CH');
INSERT INTO models VALUES ('FPE','Punto Evo', 'Fiat','4CH');
INSERT INTO models VALUES ('FF','Fiesta','Ford','6CH');
INSERT INTO models VALUES ('BMW1', 'Series 3', 'BMW', '6CH');
INSERT INTO models VALUES ('AUD1', 'A4', 'Audi', '5CH');
INSERT INTO models VALUES ('VW1', 'Golf', 'Volkswagen', '5CH');
INSERT INTO models VALUES ('MTZ1', 'Mazda3', 'Mazda', '4CH');


INSERT INTO CARS VALUES ('1245Tunis99', 'RC', '2001-02-14', 155000, 10200);
INSERT INTO CARS VALUES ('264Tunis142', 'FF', '2010-02-11', 75000, 19500);
INSERT INTO CARS VALUES ('569Tunis122', 'PCC', '2005-10-02', 85250, 15200);
INSERT INTO CARS VALUES ('1713Tunis154', 'FPE', '2012-10-10', 106000, 21000);

INSERT INTO CARS (Registration_id, model_id, dateofcirculation, Mileage, requested_price) VALUES ('2256Tunis99', 'BMW1', '2018-03-15', 34000, 25000);
INSERT INTO CARS (Registration_id, model_id, dateofcirculation, Mileage, requested_price) VALUES ('3487Tunis142', 'AUD1', '2015-07-20', 50000, 22000);
INSERT INTO CARS (Registration_id, model_id, dateofcirculation, Mileage, requested_price) VALUES ('4678Tunis122', 'VW1', '2019-01-05', 29000, 23000);
INSERT INTO CARS (Registration_id, model_id, dateofcirculation, Mileage, requested_price) VALUES ('5912Tunis154', 'MTZ1', '2020-11-25', 10000, 21000);



INSERT INTO person VALUES (3645148, 'Masmoudi', 'Ahmed', 'masm@gmail.com', '70983123');
INSERT INTO person VALUES (7498662, 'Ayadi', 'Omar', 'ayad@gmail.com', NULL);
INSERT INTO person VALUES (6784512, 'Bali', 'Imen', 'bali@gmail.com', '72145870');
INSERT INTO person VALUES (4456641, 'Salhi', 'Ali', 'salh@gmail.com', '70983145');

INSERT INTO person VALUES (5658781, 'Jalali', 'Sami', 'sjalali@gmail.com', '70234567');
INSERT INTO person VALUES (4875962, 'Mansour', 'Leila', 'leilam@gmail.com', '71234567');
INSERT INTO person VALUES (3154879, 'Kazemi', 'Reza', 'rkazemi@gmail.com', '72234567');
INSERT INTO person VALUES (2015846, 'Saad', 'Hana', 'hsaad@gmail.com', '73234567');


INSERT INTO acquisitions VALUES ('1245Tunis99', 3645148, '2007-06-20', '2010-09-17');
INSERT INTO acquisitions VALUES ('1713Tunis154', 4456641, '2014-01-03', '2015-01-02');
INSERT INTO acquisitions VALUES ('1245Tunis99', 7498662, '2010-09-18', NULL);

INSERT INTO acquisitions VALUES ('2256Tunis99', 5658781, '2018-03-20', '2021-05-15');
INSERT INTO acquisitions VALUES ('3487Tunis142', 4875962, '2015-08-01', '2018-07-30');
INSERT INTO acquisitions VALUES ('4678Tunis122', 3154879, '2019-01-10', NULL);
INSERT INTO acquisitions VALUES ('5912Tunis154', 2015846, '2020-12-01', NULL);

SELECT * FROM acquisitions;


INSERT INTO contractofsale VALUES ('C100', 3645148, '1245Tunis99', '2007-06-20', 9600);
INSERT INTO contractofsale VALUES ('C102', 4456641, '1713Tunis154', CONVERT(date, GETDATE()), 20800);
INSERT INTO contractofsale VALUES ('C103', 7498662, '1245Tunis99', '2010-09-18', 8500);

INSERT INTO contractofsale VALUES ('C200', 5658781, '2256Tunis99', '2018-03-20', 24000);
INSERT INTO contractofsale VALUES ('C201', 4875962, '3487Tunis142', CONVERT(date, GETDATE()), 21500);
INSERT INTO contractofsale VALUES ('C202', 3154879, '4678Tunis122', '2019-01-10', 22000);


select * from CONTRACTofSALE;

-- Add a new column to the CARS table
ALTER TABLE CARS ADD couleur VARCHAR(20);

-- Update color for a specific car
UPDATE CARS
SET couleur = 'Bleu'
WHERE Registration_id = '1713Tunis154';

-- Update the sale price in the CONTRACTofSALE table, assuming table and column names need correction
UPDATE CONTRACTofSALE
SET price_sale = price_sale - 300
WHERE Registration_id = '1245Tunis99'
AND Person_id = (SELECT Person_id FROM person WHERE UPPER(last_name) = 'MASMOUDI');

-- Delete contracts from CONTRACTofSALE table where the year of date_sale is before 2008
DELETE FROM CONTRACTofSALE
WHERE YEAR(date_sale) < 2008;

--Display information about all sales contracts.

select * from Contractofsale;

-- Display the list of cars in ascending order of the requested price.

select * from cars order by requested_price;


--Display the list of cars that have exceeded 100,000 kilometers.

select * from cars where Mileage>100000;

-- Display the list of vehicles whose requested price is between 7500 and 15000.

select * from cars where requested_price between 7500 and 15000;

--Display the list cars of ‘Peugeot’ and ‘Fiat’ models.
select * from cars where model_id in (select model_id from models where brand='FIAT' OR brand='PEUGEOT');

-- Display last names in capital letters, first names in lowercase for all registered persons.

select upper(last_name), lower(first_name) from person;

-- Display the total mileage of all cars

select sum(Mileage) from cars;

--Display all cars whose start date of acquisition exceeds the sale date by more than 4 days.
 
SELECT 
    c.registration_id, 
    c.date_sale, 
    a.start_date 
FROM 
    contractofsale c
JOIN 
    acquisitions a ON a.registration_id = c.registration_id AND a.person_id = c.person_id
WHERE 
    DATEADD(day, 4, c.date_sale) < a.start_date;


--Display the cars whose sale price is lower than any car of the brand "Renault".

SELECT *
FROM cars
WHERE requested_price < ANY (
    SELECT c.requested_price
    FROM cars c
    JOIN models m ON c.model_id = m.model_id
    WHERE m.brand = 'Renault'
);

SELECT c.*
FROM CARS c
JOIN models m ON c.model_id = m.model_id
WHERE c.requested_price < (SELECT MIN(c2.requested_price)
                           FROM CARS c2
                           JOIN models m2 ON c2.model_id = m2.model_id
                           WHERE m2.Brand = 'Renault');


-- Display for all contracts, their reference, the last name and first name of the person, the model, the brand, the requested price and the sale price of the car.


SELECT 
    c.contract_id, 
    p.last_name,
    p.first_name, 
    m.model,
    m.brand, 
    v.requested_price, 
    c.price_sale
FROM 
    contractofsale c 
JOIN 
    person p ON p.Person_id = c.Person_id
JOIN 
    cars v ON c.registration_id = v.registration_id
JOIN 
    models m ON v.model_id = m.model_id;

