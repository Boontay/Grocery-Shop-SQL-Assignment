DELIMITER //

CREATE PROCEDURE meatOrderNeeded()
BEGIN

    UPDATE products
    SET orderDue = 'yes'
    WHERE meatName = (SELECT productName FROM meat WHERE quantityInStock < 15);

    UPDATE products
    SET orderDue = 'no'
    WHERE meatName = (SELECT productName FROM meat WHERE quantityInStock > 20);

END;//



DELIMITER //

CREATE PROCEDURE vegOrderNeeded()
BEGIN

    UPDATE products
    SET orderDue = 'yes'
    WHERE fruitVegetableName = (SELECT productName FROM fruitVegetables WHERE quantityInStock < 15);

    UPDATE products
    SET orderDue = 'no'
    WHERE fruitVegetableName = (SELECT productName FROM fruitVegetables WHERE quantityInStock > 20);

END;//



DELIMITER //

CREATE TRIGGER Meat_Order_Due
AFTER INSERT ON meat
FOR EACH ROW BEGIN

    CALL meatOrderNeeded;

END;//



DELIMITER //

CREATE TRIGGER Veg_Order_Due
AFTER INSERT ON fruitVegetables
FOR EACH ROW BEGIN

    CALL vegOrderNeeded;

END;//



DELIMITER //

CREATE TRIGGER numberOfProductsToOrder

AFTER INSERT ON sales
FOR EACH ROW
BEGIN

	CALL AmountOfProductsRequiringOrder;

END;//



DELIMITER //

CREATE FUNCTION AmountOfProductsRequiringOrder()
RETURNS INTEGER

BEGIN
    DECLARE numberOfOrdersDue INTEGER;
    SET numberOfOrdersDue = 0;

    SELECT COUNT(*) INTO numberOfOrdersDue
    FROM products
    WHERE orderDue LIKE 'yes';

    RETURN numberOfOrdersDue;
END;//