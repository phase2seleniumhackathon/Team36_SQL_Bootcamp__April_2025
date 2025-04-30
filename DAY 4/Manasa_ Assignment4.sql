--1.     List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products

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

--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products

--SELECT *  FROM orders o
--LEFT JOIN customers c ON o.customer_id = c.customer_id
--LEFT JOIN employees e ON c.region = e.region
--LEFT JOIN shippers s ON o.ship_via = s.shipper_id
--LEFT JOIN order_details od ON o.order_id = od.order_id
--LEFT JOIN products p ON od.product_id = p.product_id;


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


--3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
--Tables used: order_details, products
---Output should have below columns:
  --  orderid,
   -- productid,
    --quantity,
    --productname

SELECT o.order_id,
       p.product_id,
       quantity,
       product_name
FROM order_details o
RIGHT JOIN  products p ON o.product_id = p.product_id;


--4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
--Tables used: categories, products

SELECT  p.product_name,
        p.supplier_id,
       ca.category_name 
FROM categories ca
FULL OUTER JOIN  products p ON  ca.category_id = p.category_id;

--5. 	Show all possible product and category combinations (Cross join).
SELECT p.product_name,
       ca.category_name
FROM products p
CROSS JOIN categories ca;


--6. 	Show all employees and their manager(Self join(left join))

SELECT e.first_name || ' ' || e.last_name AS employee_full_name,
       m.first_name || ' ' || m.last_name AS manager_full_name
FROM  employees e
LEFT JOIN employees m ON e.employee_id = m.employee_id;


--7. 	List all customers who have not selected a shipping method.
--Tables used: customers, orders
--(Left Join, WHERE o.shipvia IS NULL)

SELECT c.customer_id,
       c.company_name,
       c.contact_title,
       o.ship_address,
       o.ship_via,
       o.shipped_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;













