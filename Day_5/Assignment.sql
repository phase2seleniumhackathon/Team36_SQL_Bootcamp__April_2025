-- 1. GROUP BY with WHERE - Orders by Year and Quarter
-- Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

select * from orders

SELECT 
		Extract(year from order_date) AS Order_Year,
	 	Extract(QUARTER from order_date) AS Order_quarter,
	 
        COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM orders
WHERE freight > 100
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY 
    order_year, order_quarter;


-- 	2.GROUP BY with HAVING - High Volume Ship Regions
-- Display, ship region, no of orders in each region, min and max freight cost Filter regions where no of orders >= 5

select * from orders

SELECT
    ship_region,
    COUNT(*) AS order_id,
    MIN(freight) AS Min_freight,
    MAX(Freight) AS Max_freight
FROM Orders
WHERE ship_region IS NOT NULL
GROUP BY ship_region
HAVING COUNT(*) >= 5
ORDER BY order_id;

-- 3.Get all title designations across employees and customers ( Try UNION & UNION ALL)

select * from employees
select * from customers

-- UNION

SELECT title AS Designation
FROM employees

UNION

SELECT contact_title AS Designation
FROM customers;

-- UNION ALL

SELECT title AS Designation
FROM employees

UNION ALL

SELECT contact_title AS Designation
FROM customers;

-- 4.Find categories that have both discontinued and in-stock products
-- (Display category_id, instock means units_in_stock > 0, Intersect)

select * from categories
select * from products

SELECT category_id, units_in_stock
FROM products
WHERE units_in_stock > 0

INTERSECT

-- Products from categories that have discontinued products
SELECT category_id, units_in_stock
FROM products
WHERE category_id IN (
    SELECT category_id
    FROM products
    WHERE discontinued = 1
);
  
-- 5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT order_id
FROM order_details

EXCEPT

-- Orders that have at least one discounted item
SELECT order_id
FROM order_details
WHERE discount = 1;

select * from order_details

