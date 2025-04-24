/*7 Filtering */
/*List all products whose category_id is not 1, 2, or 3. */
SELECT *
FROM products
WHERE categoryid NOT IN (1, 2, 3)

/*Find customers whose company name starts with "A". */

SELECT *
FROM customers
WHERE companyname LIKE 'A%'

