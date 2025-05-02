--1.Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

CREATE VIEW vw_updatable_products AS 
SELECT  product_id,
        product_name,
		unit_price = unit_price*1.1,
		units_in_stock
FROM products
WHERE units_in_stock <  10;
SELECT * FROM products WHERE units_in_stock < 10


DROP VIEW IF EXISTS vw_updatable_products;


--2.)Transaction:  Update the product price for products by 10% in category id=1 Try COMMIT and
--ROLLBACK and observe what happens.
BEGIN;

UPDATE products
SET product_price = product_price * 1.10
WHERE category_id=1

DO$$
Begin
IF EXISTS (
        SELECT 1
		FROM products
		WHERE category id=1 AND product_price > 60
	    )  
		THEN
		RAISE EXCEPTION 'some prices exceed $60'
        ELSE
		RAISE NOTICE 'price update succesful'
		END if;
END$$;
COMMIT
ROLLBACK;


SELECT * FROM  products WHERE category_id =1

--3. Create a regular view which will have below details (Need to do joins):
--Employee_id,
--Employee_full_name,
--Title,
--Territory_id,
--territory_description,
--region_description

CREATE VIEW vw_regular AS
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS employee_full_name, 
       e.title,
       t.territory_id,
       t.territory_description, 
       r.region_description      
FROM employees e
JOIN employee_territory et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id 
JOIN region r ON t.region_id = r.region_id;

--4.Create a recursive CTE based on Employee Hierarchy

WITH RECURSIVE EmployeeHierarchy AS (
    WITH RECURSIVE employee_hierarchy AS (
    
    SELECT
        employee_id,
        first_name,
        last_name,
        title,
        reports_to,
        1 AS level,
        CONCAT(first_name, ' ', last_name) AS hierarchy
    FROM employees
    WHERE reports_to IS NULL
    UNION ALL
    
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.title,
        e.reports_to,
        eh.level + 1,
        CONCAT(eh.hierarchy, ' > ', e.first_name, ' ', e.last_name)
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.reports_to = eh.employee_id
)
SELECT *
FROM employee_hierarchy
ORDER BY hierarchy;






















