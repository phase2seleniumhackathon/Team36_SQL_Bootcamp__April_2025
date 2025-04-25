-- 1.Alter Table:
--  Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
--  Change the linkedin_profile column data type from VARCHAR to TEXT.
--  Add unique, not null constraint to linkedin_profile  Drop column linkedin_profile

alter table employees
add column linkedin_profile varchar(100);

alter table employees 
alter column linkedin_profile type text ;

alter table employees 
alter column linkedin_profile set not null;

alter table employees
add CONSTRAINT linkedin_profile_unique UNIQUE (linkedin_profile);

alter table employees 
drop column  linkedin_profile

 -- 2.Querying (Select)
 -- Retrieve the first name, last name, and title of all employees
 -- Find all unique unit prices of products
 -- List all customers sorted by company name in ascending order
 -- Display product name and unit price, but rename the unit_price column as price_in_usd

select * from employees

select SPLIT_PART(employeename, ' ', 1) AS first_name,
       SPLIT_PART(employeename, ' ', 2) AS last_name, title from employees;

select distinct unitprice from products

select * from customers order by companyname desc;

alter table products rename column unitprice to price_in_usd
select productname, price_in_usd from products; 

-- 3.Filtering
-- Get all customers from Germany.
-- Find all customers from France or Spain
-- Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
 
select * from customers
select * from customers where city= 'Germany'

select * from customers where city= 'France' or city= 'Spain'

select * from orders 

select * 
from orders 
where extract(YEAR FROM orderdate) = 1997
AND (freight > 50 OR shippeddate IS NOT NULL);

-- 4)Filtering
--  Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
-- List all employees who are located in the USA and have the title "Sales Representative".
-- Retrieve all products that are not discontinued and priced greater than 30.

select * from products

select productid, productname,price_in_usd from products where  price_in_usd >15;

select * from employees where country = 'USA' And title='Sales Representative';

select * 
FROM products 
WHERE discontinued = FALSE 
AND price_in_usd > 30;

-- 5) LIMIT/FETCH
--  Retrieve the first 10 orders from the orders table.
--  Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
select * from orders limit 10;

select * from orders order by orderid limit 10 offset 10

-- 6)Filtering (IN, BETWEEN)
-- List all customers who are either Sales Representative, Owner
-- Retrieve orders placed between January 1, 2013, and December 31, 2013.

select * from customers where contacttitle in ('Sales Representative','Owner');

select * 
FROM orders 
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

-- 7)Filtering
-- List all products whose category_id is not 1, 2, or 3.
-- Find customers whose company name starts with "A".

select * from products where categoryid not in ( 1,2,3);

select *from customers where companyname like 'A%'


 
-- 8) INSERT into orders table:


--  Task: Add a new order to the orders table with the following details:
-- Order ID: 11078
-- Customer ID: ALFKI
-- Employee ID: 5
-- Order Date: 2025-04-23
-- Required Date: 2025-04-30
-- Shipped Date: 2025-04-25
-- shipperID:2
-- Freight: 45.50

insert into orders (orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
   	values(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2, 45.50);


 
-- 9)Increase(Update)  the unit price of all products in category_id =2 by 10%.
-- (HINT: unit_price =unit_price * 1.10)

update products set price_in_usd = price_in_usd*1.10  where categoryid=2 