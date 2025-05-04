/*1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
*/

CREATE OR REPLACE VIEW VW_UPDATABLE_PRODUCTS AS
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK,
	DISCONTINUED
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 0
WITH
	CHECK OPTION;

-- query to check before udpateing view
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK,
	DISCONTINUED
FROM
	VW_UPDATABLE_PRODUCTS
WHERE
	UNITS_IN_STOCK < 10;

UPDATE VW_UPDATABLE_PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	UNITS_IN_STOCK < 10;

/*
2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.
*/
begin;
	update products set unit_price = unit_price * 1.10 where category_id =1;
	do $$
	begin
		if exists (select 1 from products where category_id=1 and unit_price >50)
			then raise notice 'Some unit prices are >50';
			else raise notice 'Updated products unitprice';
		end if;
end$$;

commit;

rollback;

select category_id,product_name,unit_price from products where category_id=1;


/*3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE_TERRITORY_REGION AS
SELECT
	E.EMPLOYEE_ID,
	FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_FULL_NAME,
	TITLE,
	T.TERRITORY_ID,
	TERRITORY_DESCRIPTION,
	R.REGION_DESCRIPTION
FROM
	EMPLOYEES E
	JOIN EMPLOYEE_TERRITORIES ET ON E.EMPLOYEE_ID = ET.EMPLOYEE_ID
	JOIN TERRITORIES T ON T.TERRITORY_ID = ET.TERRITORY_ID
	JOIN REGION R ON R.REGION_ID = T.REGION_ID;

SELECT * FROM VW_EMPLOYEE_TERRITORY_REGION;

--4.     Create a recursive CTE based on Employee Hierarchy

WITH RECURSIVE RCTE_EMPLOYEE AS (
		SELECT
			EMPLOYEE_ID,
			FIRST_NAME,
			LAST_NAME,
			TITLE,
			REPORTS_TO
		FROM 
			EMPLOYEES
		WHERE
			REPORTS_TO IS NULL
		UNION
		SELECT
			E.EMPLOYEE_ID,
			E.FIRST_NAME,
			E.LAST_NAME,
			E.TITLE,
			E.REPORTS_TO
		FROM
			EMPLOYEES E
			JOIN RCTE_EMPLOYEE RE ON E.REPORTS_TO = RE.EMPLOYEE_ID
	)
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	TITLE,
	REPORTS_TO
FROM RCTE_EMPLOYEE;