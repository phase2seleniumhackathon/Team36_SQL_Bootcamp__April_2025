
-- 1)Update the categoryName From “Beverages” to "Drinks" in the categories table.

update  categories 
set  category_name='Drinks' where category_name ='Beverages'

select * from categories
-- 2)Insert into shipper new record (give any values) Delete that new record from shippers table.
select * from shippers

insert into shippers (shipper_id,company_name,phone)
values (7,'Fedex','1-800-225-5345');

delete from shippers where shipper_id=7

 
-- 3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
--  Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
--  (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)

select * from products

alter TABLE products
drop constraint if exists fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

update products set category_id =1001 where category_id= 1;

delete from categories where category_id=3;

 
-- 4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
 
 
-- 5)Insert the following data to Products using UPSERT:
-- product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
-- product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
-- product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
-- (this should update the quantityperunit for product_id = 100)


insert into Products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
values (100, 'Wheat bread', '10 boxes', 13, 0, 3),
       (101, 'White bread', '5 boxes', 13, 0, 3)
ON CONFLICT (product_id) 
DO UPDATE SET quantity_per_unit = EXCLUDED.quantity_per_unit;

 
-- 6) Write a MERGE query:
-- Create temp table with name:  ‘updated_products’ and insert values as below:
 
-- productID
-- productName
-- quantityPerUnit
-- unitPrice
-- discontinued
-- categoryID
--                      	100
-- Wheat bread
-- 10
-- 20
-- 1
-- 3
-- 101
-- White bread
-- 5 boxes
-- 19.99
-- 0
-- 3
-- 102
-- Midnight Mango Fizz
-- 24 - 12 oz bottles
-- 19
-- 0
-- 1
-- 103
-- Savory Fire Sauce
-- 12 - 550 ml bottles
-- 10
-- 0
-- 2
 
--Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

-- If there are matching products and updated_products .discontinued =1 then delete 
 
-- Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

select * from products where product_id in(100,101,102,103)

delete from products where product_id =100
delete from products where product_id =101

CREATE TEMP TABLE updated_products AS
WITH vals(product_id , product_name , quantity_per_unit , unit_price , discontinued , category_id )
AS (VALUES (100, 'Wheat bread', '10', 20, 1, 5),
(101, 'White bread', '5 boxes', 19.99, 0, 5),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2))
SELECT * FROM vals;

SELECT * FROM updated_products;

MERGE INTO products p
USING updated_products AS incoming 
ON p.product_id = incoming.product_id
WHEN MATCHED AND incoming.discontinued = 1 
	THEN DELETE
WHEN MATCHED AND incoming.discontinued = 0
	THEN UPDATE SET
		product_id = incoming.product_id,
		product_name = incoming.product_name,
		quantity_per_unit = incoming.quantity_per_unit,
		unit_price = incoming.unit_price,
		discontinued = incoming.discontinued,
		category_id = incoming.category_id
WHEN NOT MATCHED AND incoming.discontinued = 0	
	THEN INSERT (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
	VALUES (incoming.product_id, incoming.product_name, incoming.quantity_per_unit, incoming.unit_price, 
	incoming.discontinued, incoming.category_id );


-- USE NEW Northwind DB:
 
-- 7)List all orders with employee full names. (Inner join)

select * from orders
select * from employees

SELECT   orders.order_id, orders.order_date,CONCAT(employees.first_name, ' ', employees.last_name) AS employeeFullName
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id;
