-- 9)Increase(Update)  the unit price of all products in category_id =2 by 10%.
-- (HINT: unit_price =unit_price * 1.10)

select * from products

update products
set unitprice = unitprice * 1.10
where categoryid = 2;
