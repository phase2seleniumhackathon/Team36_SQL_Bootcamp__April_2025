6.
	CREATE TEMP TABLE updated_products (
    product_id INT,
    product_name TEXT,
    quantity_per_unit TEXT,
    unit_price NUMERIC,
    discontinued INT,
    category_id INT
);


INSERT INTO updated_products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES 
(100, 'Wheat bread', '10', 20, 1, 5),
(101, 'White bread', '5 boxes', 19.99, 0, 5),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

INSERT INTO categories (category_id, category_name)
VALUES 
(1, 'Beverages'),
(2, 'Condiments'),
(5, 'Bakery')
ON CONFLICT (category_id) DO NOTHING; 

MERGE INTO products 
USING updated_products up
ON products.product_id = up.product_id
WHEN MATCHED AND up.discontinued = 0 THEN
    UPDATE SET 
        unit_price = up.unit_price,
        discontinued = up.discontinued
WHEN MATCHED AND up.discontinued = 0 THEN
    DELETE
WHEN NOT MATCHED AND up.discontinued = 0 THEN
    INSERT (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
    VALUES (up.product_id, up.product_name, up.quantity_per_unit, up.unit_price, up.discontinued, up.category_id);


