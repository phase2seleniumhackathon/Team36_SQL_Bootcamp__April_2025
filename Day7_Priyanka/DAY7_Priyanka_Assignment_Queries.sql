/* 1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/



SELECT 
e.employee_id,
COUNT(o.order_id) AS total_sales,
RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS rank
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY rank;


select * from employees
select * from orders


 
/* 2.Compare current order's freight with previous and next order for each customer.
  (Display order_id,  customer_id,  order_date,  freight,
   Use lead(freight) and lag(freight).*/
   

SELECT order_id, customer_id,
       order_date, freight,
    LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM  orders;
 
/* 3.Show products and their price categories, product count in each category, avg price:
      	(HINT:Create a CTE which should have price_category definition:
         	  WHEN unit_price < 20 THEN 'Low Price'
              WHEN unit_price < 50 THEN 'Medium Price'
              ELSE 'High Price'
  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2)
	 as avg_price)*/
    
	
	
with Price_categoryCTE AS (
select product_name, unit_price,
case  WHEN unit_price < 20 THEN 'Low Price'
      WHEN unit_price < 50 THEN 'Medium Price'
      ELSE 'High Price'
      end as price_category
      from  products)
select price_category,
COUNT(product_name) AS product_count,
ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM Price_categoryCTE
GROUP BY price_category
ORDER BY price_category;