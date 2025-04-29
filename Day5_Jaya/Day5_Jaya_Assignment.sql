/*Day 5:
1. Group by with WHERE - orders by year and quarter.
Display order year, quarter, order count, avg freight cost only for those orders where freight cost>100?*/
SELECT 
  EXTRACT(YEAR FROM order_date) AS order_year,
  EXTRACT(QUARTER FROM order_date) AS order_quarter,
  COUNT(*) AS order_count,
  AVG(freight) AS avg_freight_cost
FROM 
  orders
WHERE 
  freight > 100
GROUP BY 
  EXTRACT(YEAR FROM order_date),
  EXTRACT(QUARTER FROM order_date)
ORDER BY 
  order_year,
  order_quarter;

/*2.GROUP BY with HAVING - high volume ship regions.
Display ship region, no of orders in each region, min and max freight cost
Filter regions where no of orders>=5*/
SELECT 
  ship_region,
  COUNT(*) AS order_count,
  MIN(freight) AS min_freight_cost,
  MAX(freight) AS max_freight_cost
FROM 
  orders
GROUP BY 
  ship_region
HAVING 
  COUNT(*) >= 5
ORDER BY 
  order_count DESC;

/*3.Get all title designations across employees and customers (try UNION and UNION ALL)*/

SELECT title
FROM employees

UNION

SELECT contact_title
FROM customers;
------------
SELECT title
FROM employees

UNION ALL

SELECT contact_title
FROM customers;

/*4.Find categories that have both discontinued and in-stock products.
(Display category id, instock means units in stock>0, intersect)*/

SELECT category_id
FROM products
WHERE units_in_stock > 0

INTERSECT

SELECT category_id
FROM products
WHERE discontinued = 1;


/*5.Find orders that have no discounted items (Display order-id, EXCEPT)*/

SELECT order_id
FROM orders

EXCEPT

SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0;