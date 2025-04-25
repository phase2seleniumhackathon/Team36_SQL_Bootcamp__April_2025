--       Day3 Assignment ( UPSERT/MERGE/JOINS)

--- 1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.

select * from categories where category_name = 'Beverages'  -- 1 record found

update categories set category_name = 'Drinks' where category_name = 'Beverages'

select * from categories where category_name = 'Drinks'   -- 1 record updated

--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.

select * from shippers;

insert into shippers(shipper_id,company_name,phone) values(7,'USPS','1-800-482-USPS')

delete from shippers where shipper_id = 7

--3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
--        Display the both category and products table to show the cascade.
--       Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
--       (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) )

ALTER TABLE IF EXISTS products DROP CONSTRAINT IF EXISTS fk_products_categories;

alter table products
	add constraint fk_products_categories
	foreign key (category_id)
	references categories(category_id)
	on update cascade
	on delete cascade


select * from products where category_id = 1;

update categories set category_id = 1001 where category_id = 1

select * from categories

select * from products where category_id = 3;

ALTER TABLE IF EXISTS order_details DROP CONSTRAINT IF EXISTS fk_order_details_products;

alter table order_details
	add constraint fk_order_details_products
	foreign key (product_id)
	references products(product_id)
	on update cascade
	on delete cascade

delete from categories where category_id = 3;

select * from products

--4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
--           (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)


ALTER TABLE IF EXISTS orders DROP CONSTRAINT IF EXISTS fk_orders_customers;

ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

select * from customers;

select * from orders where customer_id = 'VINET'

delete from customers where customer_id = 'VINET'

select * from orders where customer_id is null;

--5)      Insert the following data to Products using UPSERT:
--		product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
--		product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
--		product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
--		(this should update the quantityperunit for product_id = 100)

  
insert into products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
				values(100,'Wheat bread',1,13,0,5)
	on conflict(product_id)
	do update
		set product_name = EXCLUDED.product_name,
			quantity_per_unit =  EXCLUDED.quantity_per_unit,
			unit_price =  EXCLUDED.unit_price,
			discontinued = EXCLUDED.discontinued,
			category_id = EXCLUDED.category_id

	select * from products where product_id = 100

	 insert into products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
				values(101,'White bread',5,13,0,5)
	on conflict(product_id)
	do update
		set product_name = EXCLUDED.product_name,
			quantity_per_unit =  EXCLUDED.quantity_per_unit,
			unit_price =  EXCLUDED.unit_price,
			discontinued = EXCLUDED.discontinued,
			category_id = EXCLUDED.category_id

	select * from products where product_id = 101

 	insert into products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
				values(100,'Wheat bread',10,13,0,5)
	on conflict(product_id)
	do update
		set product_name = EXCLUDED.product_name,
			quantity_per_unit =  EXCLUDED.quantity_per_unit,
			unit_price =  EXCLUDED.unit_price,
			discontinued = EXCLUDED.discontinued,
			category_id = EXCLUDED.category_id

	select * from products where product_id = 100

--6)      Write a MERGE query:
--     Create temp table with name:  ‘updated_products’ and insert values as below:
--                  	productID	productName		quantityPerUnit		unitPrice	discontinued	categoryID
                     	100			Wheat bread			10					20			1				5
						101			White bread			5 boxes				19.99		0				5
						102			Midnight Mango Fizz	24 - 12 oz bottles	19			0				1
						103			Savory Fire Sauce	12 - 550 ml bottles	10			0				2


--	Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
--   If there are matching products and updated_products .discontinued =1 then delete 
--  Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

select * from products where product_id in (100,101,102,103)

select * from categories;
	
merge into products p
using (
	values(100,'Wheat bread','10',20,1,5),
		  (101,'White bread','5 boxes',19.99,0,5),
		 (102,'Midnight Mango Fizz','24 - 12oz bottles',19,0,1001),
		(103,'Savory Fire Sauce','12 - 550ml bottles',10,0,2)
)	as updated_products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
	
on p.product_id = updated_products.product_id
	
when matched and updated_products.discontinued = 0	then 
	update
			set unit_price = updated_products.unit_price,
				discontinued = updated_products.discontinued
	
when matched and updated_products.discontinued = 1	then 
	delete
	
when not matched and updated_products.discontinued = 0 then 
	insert(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
		values(updated_products.product_id,updated_products.product_name,updated_products.quantity_per_unit,
				updated_products.unit_price,updated_products.discontinued,updated_products.category_id)


select * from products where product_id in (100,101,102,103)



 
--7)      List all orders with employee full names. (Inner join)


  select o.order_id,concat(e.first_name,e.last_name) as employee_fullname
	from orders o
	inner join employees e 
	on o.employee_id = e.employee_id
