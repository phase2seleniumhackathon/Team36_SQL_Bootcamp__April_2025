/*3.   Filtering */
/*	Get all customers from Germany. */

SELECT * FROM CUSTOMERS
WHERE country='Germany';

/*	Find all customers from France or Spain */
SELECT * FROM CUSTOMERS
WHERE country IN('France','Spain');

/*	Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))*/
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 2013
AND (freight>50 OR shippeddate IS NOT NULL)
