/* Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3 */

SELECT * from products
SELECT * from categories

INSERT INTO categories
VALUES (3,'Clothes','GAP')

INSERT INTO products
VALUES (100,'Wheat bread',1,13,0,3)
ON CONFLICT(productid)
DO UPDATE
SET productname = EXCLUDED.productname,
quantityperunit = EXCLUDED.quantityperunit,
unitprice = EXCLUDED.unitprice,
discontinued = EXCLUDED.discontinued,
categoryID = EXCLUDED.categoryID

