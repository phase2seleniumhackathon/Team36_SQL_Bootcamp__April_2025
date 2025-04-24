-- 7.Filtering
-- List all products whose category_id is not 1, 2, or 3.
-- Find customers whose company name starts with "A".

select * from products
where categoryid NOT IN (1, 2, 3);

select * from customers
where companyname LIKE 'A%';
