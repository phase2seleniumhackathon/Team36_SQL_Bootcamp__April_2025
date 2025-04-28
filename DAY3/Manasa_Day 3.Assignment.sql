-- Update the categoryName From “Beverages” to "Drinks" in the categories table

--UPDATE  categories WHERE categoryName IS  bevergies= drinks;
UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages';

-----Insert into shipper

INSERT INTO shippers (shipperid, companyName)
VALUES (98, 'Speedy Delivery');

SELECT * FROM shippers


DELETE  FROM shippers  WHERE shipperid = 99;

--Update customerid


ALTER TABLE products
DROP constraints IF EXISTS products_categoryid_fkey;

ALTER TABLE products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryId) 
REFERENCES categories (categoryId)
ON UPDATE CASCADE
ON DELETE CASCADE;

INSERT INTO categories(categoryId, categoryName)
VALUES (101, 'manasa');


INSERT INTO products(productid, productname, discontinued, categoryid)
VALUES 
    (78, 'soap', 0, 101),
    (79, 'milk', 0, 101);

UPDATE categories 
SET categoryid=1001
WHERE  categoryid=101;

DELETE categories WHERE categoryid=1001;

SELECT * FROM categories WHERE categoryid=1001;
SELECT * FROM products WHERE categoryid=1001;

--DELETE categories WHERE categoryid=3;


DELETE FROM categories WHERE categoryId = 3;

SELECT * FROM categories

---Delete the customer = “VINE"
ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

 ALTER TABLE orders
 ADD CONSTRAINT orders_customerid_fkey
 FOREIGN KEY(customerid)
 REFERENCES customers(customerid) 
 ON UPDATE  CASCADE
 ON DELETE SET NULL

SELECT * FROM customers WHERE customerID = 'VINET';
DELETE FROM customers WHERE customerID = 'VINET';
SELECT * FROM orders WHERE customerID IS NULL;

--  Insert the following data to Products using UPSERT:
INSERT INTO products (
    productid,
    productname,
    quantityperunit,
    unitprice,
    discontinued,
    categoryid
)
VALUES (
    100, 'Wheat bread', 1, 13, 0, 5
)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

	

INSERT INTO products (
    productid,
    productname,
    quantityperunit,
    unitprice,
    discontinued,
    categoryid
)
VALUES (
    101, 'Wheat bread', 5, 13, 0, 5
)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

INSERT INTO products (
    productid,
    productname,
    quantityperunit,
    unitprice,
    discontinued,
    categoryid
)
VALUES (
    100, 'Wheat bread', 10, 13, 0, 5
)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

SELECT * FROM products WHERE productid IN (100, 101);

--	Write a MERGE query

CREATE TEMP TABLE updated_products (
    productid INT,
    productname VARCHAR(50),
    quantityperunit VARCHAR(50),
    unitprice NUMERIC(10,2),
    discontinued INT,
    categoryid INT
);

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES
(100, 'Wheat bread', '10', 20, 1, 5),
(101, 'White bread', '5 boxes', 19.99, 0, 5),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

SELECT * FROM  updated_products;


MERGE INTO products p
USING (
    VALUES
        (100, 'Wheat bread', '10', 20, 1, 5),
        (101, 'White bread', '5 boxes', 19.99, 0, 5),
        (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
        (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)
) AS incoming(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
ON p.productid = incoming.productid
WHEN MATCHED AND incoming.discontinued = 0 THEN
PDATE SET 
        unitprice = incoming.unitprice,
        discontinued = incoming.discontinued
WHEN MATCHED AND incoming.discontinued = 1 THEN
 DELETE
WHEN NOT MATCHED AND incoming.discontinued = 0 THEN
INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (incoming.productid, incoming.productname, incoming.quantityperunit, incoming.unitprice, incoming.discontinued, incoming.categoryid);










