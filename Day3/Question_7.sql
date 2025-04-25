/*7)List all orders with employee full names. (Inner join)*/
SELECT * FROM orders o
INNER JOIN employees e 
ON o.employee_id = e.employee_id