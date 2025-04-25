--inner join

SELECT lastn_ame, first_name
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id;
--not working  up query


SELECT 
    orders.order_id,
    employees.first_name || ' ' || employees.last_name AS employee_full_name,
    orders.order_date,
    orders.ship_name,
    orders.ship_country
FROM orders
INNER JOIN employees ON employees.employee_id = orders.employee_id;
