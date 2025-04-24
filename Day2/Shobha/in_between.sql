-- 6.Filtering (IN, BETWEEN)
-- List all customers who are either Sales Representative, Owner
-- Retrieve orders placed between January 1, 2013, and December 31, 2013.

select * from  customers
where contacttitle = 'Sales Representative' or contacttitle = 'Owner';

select * from orders
where orderdate Between '2013-1-1' AND '2013-12-31';
