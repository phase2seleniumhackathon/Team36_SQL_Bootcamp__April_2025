select * from customers
where country = 'Germany';

select * from customers
where country = 'France' or country = 'Spain';

select * from orders
where extract (YEAR from orderdate) = 2014
And (freight > 50 or shippeddate is not null);
