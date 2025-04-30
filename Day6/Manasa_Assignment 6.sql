
--1. Categorize products by stock status(Display product_name, a new column stock_status whose values are based on below condition
 --units_in_stock = 0  is 'Out of Stock'
  --units_in_stock < 20  is 'Low Stock')

 select product_name,
    case
        WHEN units_in_stock = 0 THEN 'Out of Stock' 
        WHEN units_in_stock < 20 THEN 'Low Stock'
        ELSE 'In Stock'
    end as stock_status
FROM products


-- 2.  Find All Products in Beverages Category (Subquery, Display product_name,unitprice)

select * from products
select * from categories
select product_name, unit_price from products
where category_id = (select category_id from categories where category_name= 'Beverages');
 
-- 3. Find Orders by Employee with Most Sales(Display order_id,   order_date,  freight, employee_id.
-- Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)


select order_id,   
	order_date,  
	freight, 
	employee_id
from orders
where employee_id =
            (select employee_id
			  FROM 
             orders
             GROUP BY employee_id order by count(order_id)desc limit 1);
        		
select * from employees
select * from orders 
-- 4. Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)


SELECT order_id,   
       order_date,  
       freight 
FROM orders
WHERE  ship_country != 'USA'
AND freight > ANY ( SELECT freight FROM orders WHERE ship_country = 'USA');