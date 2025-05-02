-- 1.Create view vw_updatable_products (use same query whatever I used in the training)
-- Try updating view with below query and see if the product table also gets updated.
-- Update query:
-- UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

CREATE VIEW vw_product_sales_summary AS
select p.product_name,
	c.category_name,
		sum(od.quantity) as total_units_sold,
		sum(od.quantity * od.unit_price) as total_revenue
	from products p
	join order_details od on p.product_id = od.product_id
	join categories c on p.category_id = c.category_id
	group by p.product_name, c.category_name;

select * from vw_product_sales_summary

CREATE VIEW vw_updatable_products AS
select 
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM 
    products
WHERE 
    units_in_stock < 10;
	
update vw_updatable_products 
set unit_price = unit_price * 1.1 
where units_in_stock < 10;

select * from vw_updatable_products 

-- 2.Transaction:
-- Update the product price for products by 10% in category id=1
-- Try COMMIT and ROLLBACK and observe what happens.

BEGIN;

update products 
set unit_price = unit_price * 1.1 
WHERE category_id = 1;

COMMIT;
ROLLBACK;

SELECT * FROM products WHERE category_id = 1;
 
-- 3.Create a regular view which will have below details (Need to do joins):
-- Employee_id,
-- Employee_full_name,
-- Title,
-- Territory_id,
-- territory_description,
-- region_description

create view vw_employee_details AS
select 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
from 
    employees e
join 
    employee_territories et ON e.employee_id = et.employee_id
join
    territories t ON et.territory_id = t.territory_id
join 
    region r ON t.region_id = r.region_id;

select * from vw_employee_details
 
-- 4.Create a recursive CTE based on Employee Hierarchy
select * from employees

create view vw_employeehierarchy AS
with recursive cte_employeehierarchy AS (
    SELECT 
        employee_id,
        first_name,
		last_name,
        reports_to,
        0 AS level
    FROM 
        employees e
    WHERE 
        reports_to IS NULL
    
    UNION ALL
	
  --recursive  
    SELECT 
        e.employee_id,
        e.first_name,
		e.last_name,
        e.reports_to,
        eh.level+1 
    FROM 
        employees e
    INNER JOIN 
        cte_employeehierarchy eh ON e.reports_to = eh.employee_id )
select level, employee_id, first_name ||' '|| last_name as employee_name
from cte_employeehierarchy
order by level, employee_id;
		
SELECT * FROM vw_employeehierarchy
