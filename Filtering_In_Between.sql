/* 6.Filtering (IN, BETWEEN)*/
/*List all customers who are either Sales Representative, Owner*/

SELECT *
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner')

/*Retrieve orders placed between January 1, 2013, and December 31, 2013.*/
SELECT *
FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31'