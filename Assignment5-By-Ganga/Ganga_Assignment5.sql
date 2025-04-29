-- 1.      GROUP BY with WHERE - Orders by Year and Quarter
-- Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

select
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date);



select * from orders

-- 2.      GROUP BY with HAVING - High Volume Ship Regions
-- Display, ship region, no of orders in each region, min and max freight cost
select 
   ship_region, 
   min(freight) as minimun_cost,
   max(freight) as maximum_cost,
   count(order_id) as no_of_orders
 from orders
 group by(ship_region)
 Having 
 count(order_id)>=5;

--  Filter regions where no of orders >= 5
-- 3.Get all title designations across employees and customers ( Try UNION & UNION ALL)
select * from employees
select * from customers

SELECT 
    title
FROM 
    employees
UNION
SELECT 
    contact_title
FROM 
    customers;

SELECT 
    title
FROM 
    employees
UNION ALL
SELECT 
    contact_title
FROM 
    customers;


-- 4.Find categories that have both discontinued and in-stock products
-- (Display category_id, instock means units_in_stock > 0, Intersect)

SELECT 
    category_id
FROM 
    products
WHERE 
    discontinued = 1
INTERSECT
SELECT 
    category_id
FROM 
    products
WHERE 
    units_in_stock > 0;

-- 5. Find orders that have no discounted items (Display the  order_id, EXCEPT)
select 
    order_id
from
    order_details
Except
select 
	order_id
from order_details
where 
 discount > 0;

select * from order_details

