--1 Update the categoryName From “Beverages” to "Drinks" in the categories table.
update categories
set category_name ='Drinks'
where category_name ='Beverages';

--2   Insert into shipper new record (give any values) Delete that new record from shippers table.
insert into shippers (shipper_id, company_name)
values(17,'usps');
select * from shippers;
delete from shippers
where shipper_id='17';

--3 Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
alter table products
drop constraint if exists
fk_products_category;

alter table products
add constraint fk_products_category
foreign key(categoryid)
references categories(categoryid)
on update cascade
on delete cascade;


update categories
set categoryid=1001
where categoryid=1

select * from categories where categoryid=1001;

select * from products where categoryid=1001;

delete from categories
where categoryid = 3;

select * from products where categoryid =3


--4   Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to nu

select *from orders;

ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customerid
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

delete from customers where customerid='VINET';


select * from customers where customerid='VINET';

select * from orders where customerid is null;



--5   Insert the data to Products using UPSERT:

select * from products where productid in (100,101);

INSERT INTO Products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100, 'Wheat bread',1,13,0,5)
ON CONFLICT (productid) DO UPDATE
SET productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
	unitprice = EXCLUDED.unitprice,
	discontinued = EXCLUDED.discontinued,
	categoryid = EXCLUDED.categoryid;

INSERT INTO Products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (101, 'Wheat bread',5,13,0,5)
ON CONFLICT (productid) DO UPDATE
SET productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
	unitprice = EXCLUDED.unitprice,
	discontinued = EXCLUDED.discontinued,
	categoryid = EXCLUDED.categoryid;

INSERT INTO Products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100, 'Wheat bread',10,13,0,5)
ON CONFLICT (productid) DO UPDATE
SET productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
	unitprice = EXCLUDED.unitprice,
	discontinued = EXCLUDED.discontinued,
	categoryid = EXCLUDED.categoryid;	
	
--6 MERGE query

CREATE TEMP TABLE updated_products 
(productid integer,
	productname text,
	quantityperunit text,
	unitprice real,
	discontinued integer,
	categoryid integer
	
);

INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES
    (100, 'Wheat bread', '10', 20, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

MERGE INTO products AS p
USING updated_products AS up
ON p.productID = up.productID
WHEN MATCHED AND up.discontinued = 0 THEN
    UPDATE SET 
        unitPrice = up.unitPrice,
        discontinued = up.discontinued

WHEN MATCHED AND up.discontinued = 1 THEN
    DELETE

WHEN NOT MATCHED AND up.discontinued = 0 THEN
    INSERT (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
    VALUES (up.productID, up.productName, up.quantityPerUnit, up.unitPrice, up.discontinued, up.categoryID);

select * from products;	
	