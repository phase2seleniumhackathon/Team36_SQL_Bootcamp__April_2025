/*2. Querying (Select)*/
/*Retrieve the first name, last name, and title of all employees*/

SELECT
  split_part(employeeName, ' ', 1) AS first_name,
  split_part(employeeName, ' ', 2) AS last_name
FROM employees;

/* ●	 Find all unique unit prices of products */
SELECT DISTINCT unitprice
FROM products;

select * from products
select * from customers

/*List all customers sorted by company name in ascending order*/
SELECT *
FROM customers
ORDER BY companyname ASC;

/*Display product name and unit price, but rename the unit_price column as price_in_usd*/
SELECT productname, unitprice AS price_in_usd
FROM products;

