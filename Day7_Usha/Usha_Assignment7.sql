

/*		1.     Rank employees by their total sales
		(Total sales = Total no of orders handled, JOIN employees and orders table)  */


SELECT E.FIRST_NAME||' '||E.LAST_NAME AS EMPLOYEE,COUNT(O.ORDER_ID) AS NO_OF_ORDERS,
	RANK() OVER(ORDER BY COUNT(O.ORDER_ID) DESC) AS RANK_OF_NO_OF_ORDERS
	FROM ORDERS O
	INNER JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY EMPLOYEE

/* 	2.      Compare current order's freight with previous and next order for each customer.
			(Display order_id,  customer_id,  order_date,  freight,
			Use lead(freight) and lag(freight).       */


SELECT ORDER_ID,CUSTOMER_ID,ORDER_DATE,
	LAG(FREIGHT,1,FREIGHT) OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS PREVIOUS_ORDER_FREIGHT,
	FREIGHT AS CURRENT_FREIGHT,
	LEAD(FREIGHT,1,FREIGHT) OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS NEXT_ORDER_FREIGHT
	FROM ORDERS


/* 3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  
	ROUND(AVG(unit_price)::numeric, 2) as avg_price)          */


WITH PRICE_CATEGORY AS
	(SELECT PRODUCT_ID,PRODUCT_NAME,UNIT_PRICE,
			CASE WHEN UNIT_PRICE < 20 THEN 'Low Price'
				 WHEN UNIT_PRICE  < 50 THEN 'Medium Price'
				ELSE 'High Price' END AS PRICE_CATEGORY
	FROM PRODUCTS)
SELECT 	PRICE_CATEGORY,
		COUNT(*) AS PRODUCT_COUNT,
		ROUND(AVG(UNIT_PRICE)::NUMERIC,2) AS AVG_PRICE
		FROM PRICE_CATEGORY
		GROUP BY PRICE_CATEGORY
			
		
			)


