DROP DATABASE IF EXISTS groceryShop;
CREATE DATABASE groceryShop;

DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers (
    customerID CHAR(5) NOT NULL,
    firstName VARCHAR(32) DEFAULT NULL,
    lastName VARCHAR(32) DEFAULT NULL,
    city VARCHAR(32) DEFAULT NULL,
    address VARCHAR(128) DEFAULT NULL,
    email VARCHAR(128) DEFAULT NULL,
    PRIMARY KEY(customerID),
    UNIQUE KEY(email)
);
INSERT INTO customers(customerID, firstName, lastName, city, address, email) VALUES
('14436', 'Joe', 'Flynn', 'Dublin', '20 O''Connell St.', 'flynn@gmail.com'),
('14446', 'Joe', 'Flynn', 'Dublin', '20 O''Connell St.', 'joeflynn@gmail.com'),
('57649', 'Mary', 'O''Connell', 'Donegal', NULL, 'mary@gmail.com'),
('78435', 'Jack', 'Kelly', 'Cork', '53 O''Connell St.', NULL),
('33359', 'Kieran', 'Cronin', 'Tipperary', '101 O''Connell St.', 'kcronin@gmail.com'),
('13981', 'Joe', 'O''Connor', 'Limerick', '2 Thomas St.', 'joe@yahoo.com');

DROP TABLE IF EXISTS fruitVegetables;
CREATE TABLE IF NOT EXISTS fruitVegetables (
    productName VARCHAR(64) NOT NULL DEFAULT '',
    originCountry VARCHAR(64) DEFAULT NULL,
    sellByDate DATE DEFAULT NULL,
    quantityInStock FLOAT NOT NULL DEFAULT 0.0,
    price FLOAT DEFAULT NULL,
    PRIMARY KEY (productName)
);
INSERT INTO fruitVegetables (productName, originCountry, sellByDate, quantityInStock, price) VALUES
('Rooster Potatoes', 'Ireland', '2018-12-10', 30, 10.55),
('French Grapes', 'France', '2018-12-20', 80, 12.7),
('Mandarine Oranges', 'China', '2018-12-10', 30, 30.5),
('Queen''sPotatoes', 'ireland', '2018-11-20', 10, 7.6),
('Gala Apples', 'United Kingdom', '2018-12-30', 15, 4.87);

DROP TABLE IF EXISTS meat;
CREATE TABLE IF NOT EXISTS meat (
    productName VARCHAR(64) NOT NULL DEFAULT '',
    originCountry VARCHAR(64) DEFAULT NULL,
    sellByDate DATE DEFAULT NULL,
    quantityInStock FLOAT NOT NULL DEFAULT 0.0,
    price FLOAT DEFAULT NULL,
    PRIMARY KEY (productName)
);
INSERT INTO meat(productName, originCountry, sellByDate, quantityInStock, price) VALUES
('Denny''s Sausages', 'Ireland', '2018-12-20', 90, 19.55),
('Kerry Beef', 'Ireland', '2018-12-30', 60, 13.7),
('Cronins Rashers', 'Ireland', '2018-12-17', 23, 15.5),
('Bacon, Grilled', 'United States of America', '2018-11-21', 17, 37.3),
('Spring Chicken', 'UK', '2018-12-15', 30, 18.56);

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
	productType VARCHAR(64) NOT NULL DEFAULT 'N/A',
    fruitVegetablesName VARCHAR(64) NOT NULL DEFAULT 'N/A',
    meatName VARCHAR(64) NOT NULL DEFAULT 'N/A',
    supplier VARCHAR(64) NOT NULL DEFAULT '', --
    orderDue VARCHAR (3) NOT NULL DEFAULT 'No', -- Meant to be used with an UPDATE query, where there will be a check to see if the quantity remaining is below a certain threshold, if it is, the value stored here is set to 'Yes'.
    PRIMARY KEY (meatName, fruitVegetablesName),
    CONSTRAINT FOREIGN KEY (fruitVegetablesName) REFERENCES meat(productName) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (meatName) REFERENCES fruitVegetables(productName) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO products(productType, fruitVegetablesName, meatName, supplier, orderDue) VALUES
('meat', '', 'Denny''s Sausages', 'Denny''s', 'yes'),
('fruitVegetables', 'Rooster Potatoes', '', 'Gallagher''s', 'no'),
('meat', '', 'Kerry Beef', 'James Brosnan', 'no'),
('fruitVegetables', 'French Grapes', '', 'Le Grape Company', 'yes'),
('meat', '', 'Cronins Rashers', 'Cronin''s', 'no'),
('meat', '', 'Bacon, Grilled', 'O''Halloran''s''O''Halloran''s', 'yes'),
('meat', '', 'Spring Chicken', 'O''Halloran''s', 'no'),
('fruitVegetables', 'Queen''sPotatoes', '', 'Gallagher''s', 'yes'),
('fruitVegetables', 'Gala Apples', '', 'Galway Apple Company', 'yes');

DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS sales (
    customerID CHAR(5) NOT NULL,
    productName VARCHAR(64) DEFAULT NULL,
    quantityBought FLOAT DEFAULT NULL,
    purchaseDate DATE DEFAULT NULL,
    amountPaid FLOAT DEFAULT NULL,
    paymentType VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY(customerID),
    CONSTRAINT FOREIGN KEY (customerID) REFERENCES customers(customerID) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO sales (customerID, productName, quantityBought, purchaseDate, amountPaid, paymentType) VALUES
('53213', 'Rooster Potatoes', 4, '2018-10-21', 20.5, 'visa debit'),
('47241', 'Kerry Beef', 1, '2018-10-12', 8.4, 'cash'),
('93233', 'fruitVegetables', 5, '2018-11-15', 20.5, 'visa debit'),
('12218', 'Gala Apples', 2, '2018-10-27', 7.8, 'cash'),
('33782', 'Spring Chicken', 3, '2018-12-28', 31.3, 'mastercard credit');
