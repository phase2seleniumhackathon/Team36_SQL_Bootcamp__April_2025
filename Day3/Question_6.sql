--****************************************************************************---
-- 	6)      Write a MERGE query:
-- Create temp table with name:  ‘updated_products’ and insert values as below:
--****************************************************************************---

---Step 1: Create the temporary table

CREATE TEMPORARY TABLE updated_products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(50),
    unitPrice DECIMAL(10,2),
    discontinued INT,
    categoryID INT
);

select * from updated_products

-- Insert the sample data
INSERT INTO updated_products VALUES
    (100, 'Wheat bread', '10', 20.00, 1, 3),
    (101, 'White bread', '5 boxes', 19.99, 0, 3),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19.00, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10.00, 0, 2);
--****************************************************************************---
--Q6 Part A
-- Update the price and discontinued status for from below table 
-- ‘updated_products’ only if there are matching products and 
-- updated_products .discontinued =0 
--****************************************************************************---
SELECT * FROM products WHERE productid IN (100, 101, 102, 103);
UPDATE products p
SET 
    unitprice = up.unitprice,
    discontinued = up.discontinued
FROM updated_products up
WHERE 
    p.productid = up.productid
    AND up.discontinued = 0;
	


-- Preview of changes
SELECT 
    p.productid,
    p.productname,
    p.unitprice AS current_price,
    up.unitprice AS new_price,
    p.discontinued AS current_status,
    up.discontinued AS new_status
FROM 
    products p
JOIN 
    updated_products up ON p.productid = up.productid
WHERE 
    up.discontinued = 0;

--****************************************************************************---
---Q6 Part B
------If there are matching products and updated_products .discontinued =1 then delete
--****************************************************************************---

---Solution To delete products that:Exist in both 
--the main products table and the updated_products temp table Have discontinued = 1 in the updated_products table
-- 1. Check what will be deleted
SELECT * FROM products WHERE productid IN (
    SELECT productID FROM updated_products WHERE discontinued = 1
);
-- 2. Execute deletion 
DELETE FROM products
WHERE productid IN (
    SELECT up.productID 
    FROM updated_products up
    WHERE up.discontinued = 1
    AND EXISTS (
        SELECT 1 FROM products p 
        WHERE p.productid = up.productID
    )
);

-- 3. Final verification
SELECT * FROM products WHERE productid IN (
    SELECT productID FROM updated_products WHERE discontinued = 1

