--1.Rank employees by their total sales(Total sales = Total no of orders handled, JOIN employees
--and orders table)
SELECT 
    COUNT(o.order_id) AS no_of_orders,
    RANK() OVER ( ORDER BY count(o.order_id )DESC) AS total_sales
FROM orders o
LEFT JOIN employees e ON o.employee_id = e.employee_id
ORDER BY total_sales;


--2. Compare current order's freight with previous and next order for each customer.
---(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).

SELECT order_id,
       customer_id,
      order_date,
       freight,
      LEAD (freight) OVER (PARTITION BY customer_id ORDER BY freight)  AS NEXT_freight,
      LAG (freight) OVER (PARTITION BY customer_id ORDER BY freight) AS PREVIOUS_freight
FROM orders;



--3. Show products and their price categories, product count in each category, avg price:
 -- (HINT: Create a CTE which should have price_category definition: WHEN unit_price < 20 THEN 'Low Price'
 --  WHEN unit_price < 50 THEN 'Medium Price'ELSE 'High Price'
· --In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)

WITH price_category AS (
    SELECT unit_price,
           CASE
               WHEN unit_price < 20 THEN 'Low Price'
               WHEN unit_price < 50 THEN 'Medium Price'
               ELSE 'High Price'
           END AS price_category
    FROM products
)
SELECT price_category,
       COUNT(*) AS product_count,
       ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM price_category
GROUP BY price_category
ORDER BY price_category;

