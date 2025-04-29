--GROUPBY WITH WHERE
SELECT EXTRACT(YEAR FROM order_date) AS orderyear,
       EXTRACT(QUARTER FROM order_date) AS quarter,
       COUNT(*) AS ordercount,
       AVG(freight) AS avgfreightcost
FROM orders
WHERE freight > 100
GROUP BY EXTRACT(YEAR FROM order_date),
      EXTRACT(QUARTER FROM order_date)


--GROUPBY WITH HAVING BY
SELECT ship_region,
       count(*) AS orders_region,
	   MIN(freight) AS min_frieght,
	   MAX(freight) AS max_frieght
FROM orders
GROUP BY ship_region
HAVING  count(*) >= 5

-- Try UNION & UNION ALL

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

--categories that have both discontinued

SELECT p.category_id,
       p.units_in_stock > 0 AS instock,
       p.discontinued
	   --c.contact_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.units_in_stock > 0
GROUP BY (p.category_id,p.discontinued, (p.units_in_stock > 0))


SELECT category_id
FROM products
WHERE discontinued = 1 AND units_in_stock > 0
INTERSECT
SELECT category_id
FROM products
WHERE discontinued = 0 AND units_in_stock > 0;


--Display the  order_id, EXCEPT
SELECT o.order_id
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id AND od.discount > 0
--WHERE od.order_id IS NULL;













		