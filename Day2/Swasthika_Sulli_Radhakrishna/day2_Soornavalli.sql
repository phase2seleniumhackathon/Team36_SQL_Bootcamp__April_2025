--Day 2
--1 Alter Table:

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(100);

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT; 

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT linkedin_profile_unique UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;

--2 Querying (Select)

SELECT "employeeName", title
FROM employees;

select * from employees;

select * from products;

SELECT DISTINCT "unitPrice"
FROM products;

select * from customers;

SELECT *
FROM customers
ORDER BY "companyName" ASC;

SELECT "productName", "unitPrice" AS price_in_usd
FROM products;

--3  Filtering

SELECT * 
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM "orderDate") = 2014
  AND (freight > 50 OR "shippedDate" IS NOT NULL);

--4 Filtering

SELECT "productID", "productName", "unitPrice"
FROM products
WHERE "unitPrice" > 15;

SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';
  
SELECT *
FROM products
WHERE discontinued = 1
  AND "unitPrice" > 30;

--5 LIMIT/FETCH

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM orders
ORDER BY "orderID"
OFFSET 10          
LIMIT 10; 

--6 Filtering (IN, BETWEEN)

SELECT *
FROM customers
WHERE "contactTitle" IN ('Sales Representative', 'Owner');

SELECT *
FROM orders
WHERE "orderDate" BETWEEN '2013-01-01' AND '2013-12-31'

---7 Filtering
SELECT *
FROM products
WHERE "categoryID" NOT IN (1, 2, 3);

SELECT * 
FROM customers
WHERE "companyName" LIKE 'A%';

8 INSERT into orders table:

INSERT INTO orders (
    "orderID", "customerID", "employeeID", "orderDate", "requiredDate", 
    "shippedDate", "shipperID", freight
) 
VALUES (
    11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', 
    '2025-04-25', 2, 45.50
)

select * from orders;

--9 

UPDATE products
SET "unitPrice" = "unitPrice" * 1.10
WHERE "categoryID" = 2;

select * from products;


  







