                      /* DAY 4 */
/* 1.List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate   */

SELECT * FROM order_details
SELECT * FROM orders
SELECT * FROM customers
SELECT * FROM products

SELECT  c.company_name as customer,
        o.order_id as  orderid,
        p.product_name as productname,
        od.quantity,
        o.order_date as orderdate
FROM  customers c
INNER JOIN  orders o ON c.customer_id = o.customer_id
INNER JOIN  order_details od ON o.order_id = od.order_id
INNER JOIN  products p ON od.product_id = p.product_id
ORDER BY  o.order_date;

	
	
 
/*2. Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products */

SELECT 
    o.order_id,
    c.company_name as customer,
    e.first_name  as employee,
    s.company_name as shipper,
    p.product_name as product,
    od.quantity,
    o.order_date
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN  products p ON od.product_id = p.product_id
ORDER BY  o.order_id;



 
/*3.Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname  */


SELECT 
    od.order_id as orderid,
	p.product_id as productid,
    od.quantity as quantity ,
	p.product_name as productname
FROM  order_details od
RIGHT JOIN products p ON od.product_id = p.product_id
ORDER By p.product_id, od.order_id;
	
 
/*4.List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products*/

SELECT 
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id
ORDER BY c.category_name, p.product_name;


/* 5.Show all possible product and category combinations (Cross join).*/

SELECT 
    p.product_id,
    p.product_name,
    c.category_id,
    c.category_name
FROM products p
CROSS JOIN categories c
ORDER BY p.product_id, c.category_id;


 /*6.Show all employees and their manager(Self join(left join))*/

SELECT 
e1.first_name ||''|| e1.last_name as employee_name,
e2.first_name ||''|| e2.last_name as manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id;

select * from employees
 

/*7.List all customers who have not selected a shipping method.
Tables used: customers, orders (Left Join, WHERE o.shipvia IS NULL) */

SELECT 
c.customer_id,
c.company_name AS customer
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;
