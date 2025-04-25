/* 4)Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL) */


ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

 ALTER TABLE orders
 ADD CONSTRAINT orders_customerid_fkey
 FOREIGN KEY(customerid)
 REFERENCES customers(customerid) 
 ON UPDATE  CASCADE
 ON DELETE SET NULL

 DELETE FROM CUSTOMERS
 WHERE customerid ='VINET'

 SELECT * FROM customers
 WHERE customerid ='VINET'


 SELECT * FROM orders
 WHERE customerid is NULL