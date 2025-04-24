/* 5 LIMIT/FETCH */
/*Retrieve the first 10 orders from the orders table.*/

SELECT * FROM orders
LIMIT 10

/*Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/
 
SELECT * FROM orders
ORDER BY orderid
LIMIT 10
OFFSET 10

