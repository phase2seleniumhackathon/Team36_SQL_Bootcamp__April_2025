
-- 1.	Write  a function to Calculate the total stock value for a given category:
-- (Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
-- Return data type is DECIMAL(10,2)


create or replace function total_stock_value(p_category_id INT)
returns DECIMAL(10,2) AS $$
declare
    stock_value DECIMAL(10,2);
begin
    select ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    into stock_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN stock_value;
END;
$$ LANGUAGE plpgsql;


-- 2.	Try writing a   cursor query which I executed in the training.

create or replace procedure update_prices_with_cursor()
	language plpgsql
	as $$
	declare
	product_cursor  cursor for
	select product_id,product_name, unit_price, units_in_stock
	from products
	where discontinued =0;
	product_record RECORD;
	v_new_price decimal(10,2);
begin
	open product_cursor;
	loop
	fetch product_cursor into product_record;
	exit when not found;
	if product_record.units_in_stock < 10 then
	v_new_price := product_record.unit_price * 1.1;
	else v_new_price := product_record.unit_price * 0.95;
	end if;

update products
	set unit_price = round(v_new_price,2)
	where product_id = product_record.product_id;
	raise notice ' updated % price from % to %',
	product_record.product_name,
	product_record.unit_price,
	v_new_price;
end loop;
close product_cursor;
end
$$;
call update_prices_with_cursor();





