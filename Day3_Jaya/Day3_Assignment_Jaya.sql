1.
UPDATE categories
SET category_name = 'Drinks'
WHERE category_name = 'Beverages';



2.
INSERT INTO shippers
values (9,'Towers')

select * from shippers

DELETE from shippers
WHERE shipper_id=9;
	
3.
ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id) REFERENCES categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

 ALTER TABLE order_details
 ADD CONSTRAINT fk_order_details_products
 FOREIGN KEY(product_id)
 REFERENCES products(product_id) 
 ON UPDATE CASCADE
 ON DELETE CASCADE

	 select * from categories;
 
 UPDATE categories 
 SET category_id=1001
 WHERE category_id=1
	 
 DELETE FROM categories
 WHERE category_id=3;

/* 4)Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL) */

ALTER TABLE orders
DROP CONSTRAINT fk_orders_customers;

 ALTER TABLE orders
 ADD CONSTRAINT fk_orders_customers
 FOREIGN KEY(customer_id)
 REFERENCES customers(customer_id) 
 ON UPDATE  CASCADE
 ON DELETE SET NULL
	 
 DELETE FROM CUSTOMERS
 WHERE customer_id ='VINET'
	 
 SELECT * FROM customers
 WHERE customer_id ='VINET'
	 
 SELECT * FROM orders
 WHERE customer_id is NULL


/* 5.Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3 */
	 
SELECT * from products
SELECT * from categories

INSERT INTO categories
VALUES (3,'Games','Ludo');
	 
INSERT INTO products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100,'Wheat bread',1, 13, 0, 3)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = EXCLUDED.product_name,
quantity_per_unit = EXCLUDED.quantity_per_unit,
unit_price = EXCLUDED.unit_price,
discontinued = EXCLUDED.discontinued,
category_id = EXCLUDED.category_id;


INSERT INTO products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (101,'Wheat bread',5, 13, 0, 3)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = EXCLUDED.product_name,
quantity_per_unit = EXCLUDED.quantity_per_unit,
unit_price = EXCLUDED.unit_price,
discontinued = EXCLUDED.discontinued,
category_id = EXCLUDED.category_id;


INSERT INTO products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100,'Wheat bread',10, 13, 0, 3)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = EXCLUDED.product_name,
quantity_per_unit = EXCLUDED.quantity_per_unit,
unit_price = EXCLUDED.unit_price,
discontinued = EXCLUDED.discontinued,
category_id = EXCLUDED.category_id;













/*7)List all orders with employee full names. (Inner join)*/

SELECT 
    o.order_id,
    e.first_name || ' ' || e.last_name AS employee_full_name
FROM 
    orders o
JOIN 
    employees e ON o.employee_id = e.employee_id;
