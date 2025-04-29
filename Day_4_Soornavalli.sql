----1.List all customers and the products they ordered with the order date. (Inner join)

SELECT 
    customers.company_name AS customers,
	orders.order_id,
    products.product_name,
    order_details.quantity,
    orders.order_date	
FROM 
    customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;


----2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)

SELECT 
    orders.order_id,
    customers.customer_id,
    (employees.first_name || ' '|| employees.last_name ) AS employees_name,
    shippers.shipper_id,
    products.product_name,
    order_details.quantity
FROM 
    orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
LEFT JOIN employees ON orders.employee_id = employees.employee_id
LEFT JOIN shippers ON orders.ship_via = shippers.shipper_id
LEFT JOIN order_details ON orders.order_id = order_details.order_id
LEFT JOIN products ON order_details.product_id = products.product_id;

 
---3.Show all order details and products (include all products even if they were never ordered). (Right Join)

SELECT 
    order_details.order_id,
    products.product_id,
    order_details.quantity,
    products.product_name
FROM 
    order_details
RIGHT JOIN products ON order_details.product_id = products.product_id;

----4.List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)    

SELECT 
    categories.category_id,
    products.product_name
FROM 
    categories
FULL OUTER JOIN products ON categories.category_id = products.category_id;

-----5.Show all possible product and category combinations (Cross join).

SELECT 
    products.product_name,
    categories.category_name
FROM 
    products
CROSS JOIN categories;


-----6.Show all employees who have the same manager(Self join)

SELECT 
    e1.employee_id AS employee1_id,
    e1.first_name || ' ' || e1.last_name AS employee1_name,
    e2.employee_id AS employee2_id,
    e2.first_name || ' ' || e2.last_name AS employee2_name,
    m.employee_id AS manager_id,
    m.first_name || ' ' || m.last_name AS manager_name
FROM 
    employees e1
JOIN employees e2 
    ON e1.reports_to = e2.reports_to AND e1.employee_id < e2.employee_id
JOIN employees m 
    ON e1.reports_to = m.employee_id;


-----7.List all customers who have not selected a shipping method.

SELECT DISTINCT 
    customers.customer_id,
    customers.company_name
FROM 
    customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.ship_via IS NULL;

