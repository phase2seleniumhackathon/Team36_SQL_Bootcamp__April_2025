 /* Day 3 */

   /*USE Northwind from Kaggle:*/
  /*1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

	 UPDATE categories
      SET categoryName = 'Drinks'
      WHERE categoryName = 'Beverages';
  
   select * from categories
  
 
   /* 2) Insert into shipper new record (give any values) Delete that new record from shippers table.  */

     INSERT INTO shippers (shipperID , companyName)
     VALUES ('4', 'USPS');

	 DELETE from shippers
     WHERE shipperid=4

	 select * from shippers

	 
  /*3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both
  category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)*/
 
ALTER TABLE products
DROP CONSTRAINT products_categoryid_fkey;

ALTER TABLE products
ADD CONSTRAINT fk_category_id
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryID = 1001
WHERE categoryID = 1;

SELECT * FROM products WHERE categoryID = 1001;


select * from categories

DELETE FROM categories WHERE categoryID = 3;
 
 
   /*4)  Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
   (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

   ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
on update cascade
ON DELETE SET NULL;

DELETE FROM customers
WHERE customerID = 'VINET';

 SELECT * FROM orders
 WHERE customerid is NULL

  select * from customers where customerID = 'VINET'
 
    /*5) Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100)*/

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


       /*6)      Write a MERGE query: */
 /*Create temp table with name:  ‘updated_products’ and insert values as below:*/
 

CREATE TEMP TABLE updated_products (productID INTEGER,productName VARCHAR(50),
                                    quantityperUnit VARCHAR(50), unitPrice NUMERIC,
                                     discontinued BOOLEAN,categoryID INTEGER);

INSERT INTO updated_products (productID,productName,quantityperUnit,
                              unitPrice,discontinued,categoryID)

              VALUES  (100,'Wheat bread','10',20,true,5),
                      (101,'White bread','5 boxes',19.99,false,5),
                      (102,'Midnight Mango Fizz','24 - 12 oz bottles',19,false,1),
                       (103,'Savory Fire Sauce','12 - 550 ml bottles',10,false,2);

SELECT * FROM updated_products;

SELECT * FROM products WHERE product_id IN (100,101,102,103);



/* Update the price and discontinued status for from below table ‘updated_products’ only 
if there are matching products and updated_products .discontinued =0 */
/*If there are matching products and updated_products .discontinued =1 then delete */
/*Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.*/



	UPDATE products
SET 
    unitPrice = up.unitPrice,
    discontinued = up.discontinued::int
FROM updated_products up
WHERE 
    products.productID = up.productID
    AND up.discontinued = FALSE;

	select * from products
	

DELETE FROM products
USING updated_products up
WHERE 
    products.productID = up.productID
    AND up.discontinued = TRUE;








