--4. Filtering
-- Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
-- List all employees who are located in the USA and have the title "Sales Representative".
-- Retrieve all products that are not discontinued and priced greater than 30.

select productid, productname,unitprice
from products
where unitprice > 15;

select * from employees
where country = 'USA' AND title = 'Sales Representative';

select * from products
where discontinued = 0 AND unitprice > 30;
