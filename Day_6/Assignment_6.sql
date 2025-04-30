-- 1.Categorize products by stock status
-- (Display product_name, a new column stock_status whose values are based on below condition
--  units_in_stock = 0  is 'Out of Stock'
--        units_in_stock < 20  is 'Low Stock')

select * from products

select 
product_name,
CASE
When units_in_stock =0 then 'Out of Stock'
When units_in_stock <20 then 'Low Stock'
END as stock_status
from products;

-- 2.Find All Products in Beverages Category
-- (Subquery, Display product_name,unitprice)

select * from products
select * from categories

SELECT 
    product_name,
    unit_price
FROM 
    products
WHERE 
    category_id = (
        SELECT category_id
        FROM categories
        WHERE category_name = 'Beverages'
    );

-- 3.Find Orders by Employee with Most Sales
-- (Display order_id,   order_date,  freight, employee_id.
-- Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)

select * from employees
select * from order_details

select * from orders

select 
order_id,
order_date,
freight,
employee_id
from orders
where
employee_id = (
        SELECT employee_id
        FROM orders
        GROUP BY employee_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    );

-- 4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
-- (Subquery, Try with ANY, ALL operators)

-- ALL
SELECT 
    order_id,
    order_date,
    freight,
    ship_country
FROM 
    orders
WHERE 
    ship_country != 'USA'
    AND freight > ALL (
        SELECT freight 
        FROM orders 
        WHERE ship_country = 'USA'
    );

-- ANY
	SELECT 
    order_id,
    order_date,
    freight,
    ship_country
	
	FROM ORDERS
	
	WHERE SHIP_COUNTRY !='USA'
	AND FREIGHT > ANY( SELECT FREIGHT FROM ORDERS WHERE SHIP_COUNTRY='USA');
