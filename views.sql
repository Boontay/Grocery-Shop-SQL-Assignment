CREATE VIEW Shop_Products AS
SELECT DISTINCT productType AS 'Product Type', supplier AS 'Supplier', meatName AS 'Product Name'
FROM products
UNION
SELECT DISTINCT productType AS 'Product Type', supplier AS 'Supplier', fruitVegetablesName AS 'Product Name'
FROM products;

CREATE VIEW Sales_Over_100 AS
SELECT DISTINCT customerID AS 'Customer ID', productName AS 'Product Name', quantityBought AS 'Quantity Bought', purchaseDate AS 'Purchase Date', amountPaid AS 'Amount Paid', paymentType AS 'Payment Type'
FROM sales
GROUP BY purchaseDate
HAVING amountPaid > 100.0;

CREATE VIEW Customers_That_Bought_Goods_Before_31st_October AS
SELECT *
FROM customers
WHERE EXISTS (SELECT customerID FROM sales WHERE purchaseDate < '2018-10-31');

CREATE INDEX showAmountPaid ON sales(amountPaid);
CREATE INDEX showSupplier ON products(supplier);
CREATE INDEX showPurchaseDate ON sales(purchaseDate);