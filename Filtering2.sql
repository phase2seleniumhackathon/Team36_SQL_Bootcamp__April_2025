/*4.Filtering */
/* Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.*/
SELECT productid,productname,unitprice FROM products
WHERE unitprice>15


/*List all employees who are located in the USA and have the title "Sales Representative".*/
SELECT * FROM employees
WHERE country='USA' AND title='Sales Representative'

/*Retrieve all products that are not discontinued and priced greater than 30.*/
SELECT * FROM products
WHERE discontinued=1 AND unitprice>30