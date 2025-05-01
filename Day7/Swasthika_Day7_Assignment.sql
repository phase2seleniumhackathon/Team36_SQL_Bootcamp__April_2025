--1.Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)
 select * from employees;
 select * from orders;
select employees.employee_id,employees.first_name,count(order_id) as Total_sales,
rank() over (order by count(orders.order_id) desc) as employees_rank
from orders 
join employees on employees.employee_id = orders.employee_id
group by employees.employee_id, employees.first_name
order by total_sales desc;

 
--2.Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).

select * from orders;

select order_id, customer_id, order_date, freight,
   lag(freight) over (partition by customer_id order by order_date) as previous_freight,
   lead(freight) over (partition by customer_id order by order_date) as next_order_freight
   from orders;

--3.Show products and their price categories, product count in each category, avg price:
--(HINT:
--Create a CTE which should have price_category definition:
--WHEN unit_price < 20 THEN 'Low Price'--WHEN unit_price < 50 THEN 'Medium Price'
--ELSE 'High Price'
--In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)

WITH show_product_categories AS(
SELECT product_id, product_name,
CASE 
    WHEN unit_price < 20 THEN 'Low Price'
    WHEN unit_price < 50 THEN 'Medium Price'
    ELSE 'High Price'
	END AS price_category FROM products 
)
SELECT s.price_category, COUNT(*) AS product_count, ROUND(AVG(p.unit_price)::numeric, 2) AS avg_price
FROM products p
JOIN show_product_categories s
ON s.product_id = p.product_id
GROUP BY (s.price_category)
ORDER BY product_count DESC;



