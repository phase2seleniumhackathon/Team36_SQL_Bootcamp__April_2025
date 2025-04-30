--1.GROUP BY with WHERE - Orders by Year and Quarter  Dispaly, order year, quarter, order count,avg freight 
--cost only for those orders where freight cost>100
SELECT * FROM ORDERS

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM orders
WHERE freight > 100
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;

--2. GROUP BY with HAVING - High Volume Ship Regions Display,ship region,no of orders in each region, 
--min and max freight cost Filter regions where no of orders >=5

SELECT
    ship_region,
    COUNT(*) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_region
HAVING COUNT(*) >= 5
ORDER BY order_count DESC;

--3.Get all title designations across employees and customers (Try UNION and UNION ALL)
SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers;

SELECT title FROM employees
UNION 
SELECT contact_title FROM customers;

--4.Find categories that have both discontinued and in-stock products(Display category_id,instock means units_In_stock>0, intersect)

SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT

SELECT category_id
FROM products
WHERE units_in_stock > 0;
***********************

SELECT category_id,
units_in_stock as instock
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE discontinued = 1
)
INTERSECT
SELECT category_id,
units_in_stock as instock
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE units_in_stock > 0
);

**********************************

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

--5.Find orders that have discounted items(Display order_id, EXCEPT)
-- All orders
SELECT order_id
FROM order_details

EXCEPT

-- Orders where all items have no discount
SELECT order_id
FROM order_details
WHERE discount = 0;








