--ALTER
ALTER TABLE employees
ADD  linkedin_profile VARCHAR(255);

 ALTER TABLE employees
 ALTER column  linkedin_profile TYPE TEXT;

 ALTER TABLE employees
 ALTER column linkedin_profile not null

ALTER TABLE employees
ADD constraint Unique_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE  employees
DROP  column linkedin_profile;

--Querying (Select)
 SELECT
  split_part(employeeName, ' ', 1) AS first_name,
  split_part(employeeName, ' ', 2) AS last_name
FROM employees;
--limit 5

SELECT DISTINCT unitprice
FROM products;

SELECT * FROM customers ORDER BY companyname ASC;

SELECT 
    productName,
    unitprice AS price_in_usd
FROM  products;
	
--FIltering
 SELECT * FROM customers
 WHERE country=  Germany;

 SELECT *
FROM customers
WHERE country = 'France' OR country = 'Spain';


--SELECT *
 -- FROM orders
  --WHERE EXTRACT(YEAR FROM orderDate) = 1997
  --AND (freight > 50 OR shippedDate IS NOT NULL);
  
 SELECT *
  FROM orders
  WHERE EXTRACT(YEAR FROM orderDate) = 2014
  AND (freight > 50 OR shippedDate IS NOT NULL);


--Filtering

SELECT  productId,productName,unitPrice From products
 WHERE unitPrice > 15;

SELECT * FROM employees
WHERE country = 'USA' AND title = 'Sales Representative';

SELECT *  FROM  products WHERE discontinued = 1
AND unitPrice > 30; 

--LIMIT/FETCH
SELECT * FROM orders
 LIMIT 10;

SELECT * FROM orders
ORDER BY orderId
LIMIT 10 OFFSET 10;

--Filtering (IN, BETWEEN)
 SELECT * FROM customers WHERE contacttitle IN( 'Sales Representative', 'Owner');
 SELECT * FROM orders  WHERE orderdate  BETWEEN '2013-01-01' AND '2013-12-31'

-- Filtering
SELECT * FROM products WHERE categoryId NOT IN (1,2,3)
SELECT * FROM customers WHERE companyname LIKE 'A/'

-- INSERT into orders table
INSERT INTO orders (
    orderid,
    customerid,
    employeeid,
    orderdate,
    requireddate,
    shippeddate,
    shipperid,
    freight
) VALUES ( 11078, 'ALFKI', 5, '2025-04-23', '2025-04-30',
    '2025-04-25', 2,  45.50);
SELECT * FROM orders


--Increase(Update)
SELECT * FROM products;
UPDATE product set unitprice*1.10 WHERE categoryid=2;
SELECT * FROM products;





	
