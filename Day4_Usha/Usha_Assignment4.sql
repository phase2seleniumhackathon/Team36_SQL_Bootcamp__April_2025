-- Day4 Assignment 4

--1.     List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:
 --   companyname AS customer,
 --   orderid,
  --  productname,
 --   quantity,
 --   orderdate

select * from customers; --- company name as customer
select * from orders;  -- get order_date ,order_id -- join  orders and customers using  customer_id
select * from order_details  -- get quantity  --join orders and order_details on order_id
select* from products; -- get product_name--join order_details and products on product_id

SELECT
	C.COMPANY_NAME AS CUSTOMER,
	O.ORDER_ID AS ORDER_ID,
	P.PRODUCT_NAME AS PRODUCTNAME,
	OD.QUANTITY AS QUANTITY,
	O.ORDER_DATE AS ORDERDATE
FROM
	CUSTOMERS C
	INNER JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
	INNER JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	INNER JOIN PRODUCTS P ON P.PRODUCT_ID = OD.PRODUCT_ID


--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
--      Tables used: orders, customers, employees, shippers, order_details, products

	SELECT * FROM EMPLOYEES
	SELECT * FROM SHIPPERS;
	SELECT DISTINCT SHIP_VIA FROM ORDERS;

SELECT	
	O.ORDER_ID AS ORDER_ID,
	O.ORDER_DATE AS ORDERDATE,
	C.COMPANY_NAME AS CUSTOMER,
	CONCAT(E.FIRST_NAME,E.LAST_NAME) AS EMPLOYEE,
	SH.COMPANY_NAME AS SHIPPER,
	P.PRODUCT_NAME AS PRODUCTNAME,
	OD.QUANTITY AS QUANTITY
FROM
	CUSTOMERS C
	LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
	LEFT JOIN SHIPPERS SH ON SH.SHIPPER_ID = O.SHIP_VIA
	LEFT JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	LEFT JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OD.PRODUCT_ID



--3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
--     Tables used: order_details, products
--  Output should have below columns:    orderid,    productid,    quantity,    productname


SELECT OD.ORDER_ID,P.PRODUCT_ID,OD.QUANTITY,P.PRODUCT_NAME
	FROM ORDER_DETAILS OD
	RIGHT JOIN PRODUCTS P ON P.PRODUCT_ID=OD.PRODUCT_ID


--4. 	List all product categories and their products — including categories that have no products, 
--        and products that are not assigned to any category.(Outer Join)
--      Tables used: categories, products

 
SELECT P.PRODUCT_ID,P.PRODUCT_NAME,C.CATEGORY_NAME
	FROM PRODUCTS P
	FULL OUTER JOIN CATEGORIES C ON C.CATEGORY_ID = P.CATEGORY_ID


--5. 	Show all possible product and category combinations (Cross join).

SELECT P.PRODUCT_ID,P.PRODUCT_NAME,C.CATEGORY_ID,C.CATEGORY_NAME
	FROM PRODUCTS P
	CROSS JOIN CATEGORIES C


--6. 	Show all employees and their manager(Self join(left join))


SELECT * FROM EMPLOYEES;

SELECT CONCAT(EE.FIRST_NAME,' ',EE.LAST_NAME) AS EMPLOYEE, CONCAT(EM.FIRST_NAME,' ',EM.LAST_NAME) AS MANAGER
	FROM EMPLOYEES EE
	LEFT  JOIN EMPLOYEES EM ON EE.EMPLOYEE_ID !=EM.EMPLOYEE_ID
	AND EE.REPORTS_TO = EM.EMPLOYEE_ID


--7. 	List all customers who have not selected a shipping method.
--		Tables used: customers, orders
--		(Left Join, WHERE o.shipvia IS NULL)

SELECT C.COMPANY_NAME AS CUSTOMER
	FROM CUSTOMERS C
	LEFT JOIN ORDERS O ON O.CUSTOMER_ID=C.CUSTOMER_ID
	WHERE O.SHIP_VIA IS NULL



