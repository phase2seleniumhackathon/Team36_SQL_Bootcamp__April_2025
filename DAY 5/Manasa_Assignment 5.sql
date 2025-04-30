--1.      GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT EXTRACT(YEAR FROM order_date) AS orderyear,
       EXTRACT(QUARTER FROM order_date) AS quarter,
       COUNT(*) AS ordercount,
       AVG(freight) AS avgfreightcost
FROM orders
WHERE freight > 100
GROUP BY EXTRACT(YEAR FROM order_date),
      EXTRACT(QUARTER FROM order_date)


--2.      GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
 --Filter regions where no of orders >= 5
SELECT ship_region,
       count(*) AS orders_region,
	   MIN(freight) AS min_frieght,
	   MAX(freight) AS max_frieght
FROM orders
GROUP BY ship_region
HAVING  count(*) >= 5

--3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)


SELECT title
FROM employees
UNION
SELECT contact_title
FROM customers

SELECT title
FROM employees
UNION ALL
SELECT contact_title
FROM customers

--4.      Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)


SELECT p.category_id,
       p.units_in_stock > 0 AS instock,
       p.discontinued
	   --c.contact_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.units_in_stock > 0
GROUP BY (p.category_id,p.discontinued, (p.units_in_stock > 0))


--SELECT category_id
--FROM products
--WHERE discontinued = 1 AND units_in_stock > 0
--INTERSECT
--SELECT category_id
--FROM products
--WHERE discontinued = 0 AND units_in_stock > 0;


-- 5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)
     
SELECT o.order_id
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id AND od.discount > 0
--WHERE od.order_id IS NULL;














		
