--INNER JOIN
SELECT c.company_name AS customer,
       o.order_id AS orderid,
       p.product_name AS productname,
       od.quantity,
       o.order_date AS orderdate
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
ORDER BY c.company_name, o.order_date;

--LEFT JOIN
SELECT *  FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON c.region = e.region
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;


SELECT e.first_name || ' ' || e.last_name AS employee_full_name,
       o.order_date,
	   c.contact_name,
	   od.quantity,
	   p.product_name,
	   c.phone
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON c.region = e.region
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;


--RIGHT JOIN
SELECT o.order_id,
       p.product_id,
       quantity,
       product_name
FROM order_details o
RIGHT JOIN  products p ON o.product_id = p.product_id;


--OUTER JOIN
SELECT  p.product_name,
        p.supplier_id,
       ca.category_name 
FROM categories ca
FULL OUTER JOIN  products p ON  ca.category_id = p.category_id;

--CROSS JOIN
SELECT p.product_name,
       ca.category_name
FROM products p
CROSS JOIN categories ca;


--Self join(left join)
SELECT e.first_name || ' ' || e.last_name AS employee_full_name,
       m.first_name || ' ' || m.last_name AS manager_full_name
FROM  employees e
LEFT JOIN employees m ON e.employee_id = m.employee_id;


--Left Join, WHERE o.shipvia IS NULL
SELECT c.customer_id,
       c.company_name,
       c.contact_title,
       o.ship_address,
       o.ship_via,
       o.shipped_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;













