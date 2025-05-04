/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)
*/

SELECT
	E.EMPLOYEE_ID,
	COUNT(ORDER_ID) AS TOTAL_SALES,
	RANK() OVER (ORDER BY COUNT(O.ORDER_ID)) AS SALES_RANK
FROM
	ORDERS O
	JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
GROUP BY E.EMPLOYEE_ID;

/*2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).
*/

SELECT
	ORDER_ID,
	CUSTOMER_ID,
	ORDER_DATE,
	FREIGHT,
	LEAD(FREIGHT) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE DESC ) AS FREIGT_LEAD,
	LAG(FREIGHT) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE DESC) AS FREIGT_LAG
FROM
	ORDERS;

/*
3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  
ROUND(AVG(unit_price)::numeric, 2) as avg_price)
*/
WITH cte_price_category as(
SELECT 
	product_name,product_id,category_id,
	unit_price,
CASE
	WHEN unit_price < 20 THEN 'Low Price'
	WHEN unit_price < 50 THEN 'Medium Price'
	ELSE 'High Price'
END as price_category
FROM products)

SELECT
	price_category,category_id,
	COUNT(product_id),
	ROUND(AVG(unit_price)::numeric, 2) as avg_price
	FROM cte_price_category
	group by
	category_id,price_category
	order by category_id;