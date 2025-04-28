/*1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate   */

SELECT * FROM customers; --customerid pk
SELECT * FROM orders;--orderid pk
SELECT * FROM order_details;--productid pk
SELECT * FROM products;
SELECT  customers.company_name AS customer,orders.order_id
FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id;

SELECT orders.order_id,order_details.quantity,orders.order_date
FROM orders 
INNER JOIN order_details ON orders.order_id = order_details.order_id;

SELECT products.product_id
FROM order_details 
INNER JOIN products ON order_details.product_id = products.product_id;

SELECT customers.company_name AS customer,orders.order_id,order_details.quantity,orders.order_date,products.product_id
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;

/*2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products */
SELECT * FROM customers; 
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM products;
SELECT * FROM employees;
SELECT * FROM shippers;
SELECT orders.order_id,customers.company_name AS customer,employees.first_name || ' ' || employees.last_name AS employee,
    shippers.company_name AS shipper,products.product_name,order_details.quantity,orders.order_date
FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.customer_id
LEFT JOIN employees  ON orders.employee_id = employees.employee_id
LEFT JOIN shippers ON orders.ship_via = shippers.shipper_id
LEFT JOIN order_details  ON orders.order_id = order_details.order_id
LEFT JOIN products ON order_details.product_id = products.product_id;

/*3.Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products */
SELECT * FROM order_details;
SELECT * FROM products;
SELECT order_details.order_id,products.product_id,order_details.quantity,products.product_name
FROM order_details
RIGHT JOIN products ON products.product_id = order_details.product_id;

/*4.List all product categories and their products 
including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products*/
SELECT * FROM products;
SELECT * FROM categories;
SELECT products.product_id,products.supplier_id,products.unit_price,products.product_name,
categories.category_name,categories.category_id,categories.description
FROM products 
FULL OUTER JOIN categories  
ON categories.category_id = products.category_id;

/*5.Show all possible product and category combinations (Cross join).*/
SELECT * FROM products;
SELECT * FROM categories;
SELECT products.product_id,products.product_name,categories.category_id,categories.category_name
FROM products 
CROSS JOIN categories 

/*.Show all employees and their manager(Self join(left join))*/
SELECT * FROM employees;
SELECT employees.employee_id,employees.first_name || ' ' || employees.last_name AS employee_name,
 manager.employee_id AS manager_id,manager.first_name || ' ' || manager.last_name AS manager_name
FROM employees
LEFT JOIN employees manager
ON employees.reports_to = manager.employee_id;

/*7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL) */
SELECT * FROM customers; 
SELECT * FROM orders;
SELECT customers.customer_id, orders.order_id, orders.shipped_date,orders.ship_via FROM customers 
LEFT JOIN orders 
ON orders.customer_id = customers.customer_id
WHERE orders.ship_via IS NULL;



