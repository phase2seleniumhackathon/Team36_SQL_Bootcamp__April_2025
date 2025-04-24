--5. LIMIT/FETCH
-- Retrieve the first 10 orders from the orders table.
-- Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).

select * from orders
limit 10;

select * from orders
limit 10 offset 10;
