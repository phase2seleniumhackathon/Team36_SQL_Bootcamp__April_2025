/*1. Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

select * from categories

UPDATE categories 
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages' ;

/*2. Insert into shipper new record (give any values) Delete that new record from shippers table. */

select * from shippers

INSERT INTO shippers
values (4,'COSTCO')

DELETE from shippers
WHERE shipperid=4

/* 3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE) */

SELECT * FROM categories;
SELECT * FROM products ;


ALTER TABLE products
DROP CONSTRAINT products_categoryid_fkey;

 ALTER TABLE products
 ADD CONSTRAINT products_categoryid_fkey
 FOREIGN KEY(categoryid)
 REFERENCES categories(categoryid) 
 ON UPDATE  CASCADE
 ON DELETE CASCADE

ALTER TABLE order_details
DROP CONSTRAINT order_details_productid_fkey;

 ALTER TABLE order_details
 ADD CONSTRAINT order_details_productid_fkey
 FOREIGN KEY(productid)
 REFERENCES products(productid) 
 ON UPDATE  CASCADE
 ON DELETE CASCADE

 
 UPDATE categories 
 SET categoryId=1001
 WHERE categoryId=1

 DELETE FROM categories
 WHERE categoryid=3
 

