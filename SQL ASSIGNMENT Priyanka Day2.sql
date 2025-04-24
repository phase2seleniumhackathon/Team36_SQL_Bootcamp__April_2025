1)      Alter Table:

/* Add a new column linkedin_profile to employees table to store LinkedIn URLs as 
varchar.*/


Alter table employees
add linkedin_profile varchar(200)


/* Change the linkedin_profile column data type from VARCHAR to TEXT.*/

Alter table employees
Alter column linkedin_profile type Text

/* Add unique, not null constraint to linkedin_profile*/

alter table employees
alter column linkedin_profile set not null

/* Drop column linkedin_profile */

alter table employees 
drop column linkedin_profile 


select * from employees

-------------------------------------------------------------------------------------
/* Querying (Select) */
/* Retrieve the employee name and title of all employees */

select EmployeeName,title
 from employees

/* Find all unique unit prices of products */

select distinct unitPrice
from  products

/* List all customers sorted by company name in ascending order*/

select * from customers
order by companyName asc

/* Display product name and unit price, but rename the unit_price column as price_in_usd */
select productName, unitprice As price_in_usd
from products

-------------------------------------------------------------------------------------------

    /* Filtering */
/*	Get all customers from Germany. */

select * from customers
where country = 'Germany'


/*Find all customers from France or Spain*/

select * from customers
where country in ('France' , 'Spain')



/*Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the 
shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))  */

select * from orders
where extract (YEAR FROM orderdate)=2014
and (freight>50 or shippedDate is not null)

-------------------------------------------------------------------------------------------------------

     /*4)      Filtering  */
 /*Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.*/

 select productId, productName,unitPrice from products
 where unitPrice > 15

 
/*List all employees who are located in the USA and have the title "Sales Representative".*/

select * from employees
where country='USA' and title='Sales Representative'


/*Retrieve all products that are not discontinued and priced greater than 30.*/

select * from products
where  discontinued = 0 and unitPrice > 30

-----------------------------------------------------------------------------------------------

  /*5)      LIMIT/FETCH  */
 /* Retrieve the first 10 orders from the orders table.*/
  select * from orders
  limit 10
 
 /*Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20). */

 select * from orders
 offset 10
 limit 10

 -----------------------------------------------------------------------------------------------

  /* 6)      Filtering (IN, BETWEEN) */
    /*List all customers who are either Sales Representative, Owner */

	select * from customers
	where contactTitle in ('Sales Representative', 'Owner')


/*Retrieve orders placed between January 1, 2013, and December 31, 2013.*/

 select * from orders
 where orderDate between '2013-01-01' and '2013-12-31'



---------------------------------------------------------------------------------------------------

/*   7)      Filtering */

/*List all products whose category_id is not 1, 2, or 3.*/

select * from products
where categoryID not in (1,2,3)



/*Find customers whose company name starts with "A".*/

select * from customers
where companyName like 'A%'

---------------------------------------------------------------------------------------------------

 /* INSERT into orders table:


 Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50   */


INSERT INTO orders (orderid,customerid,employeeid,orderdate,
                    requireddate,shippeddate, shipperid,freight)
VALUES (11078,'ALFKI',5,'2025-04-23','2025-04-30',
  '2025-04-25',2,45.50)



  select * from orders



 ----------------------------------------------------------------------------------
 /* 9.Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10) */

update products
set unitPrice = unitPrice * 1.10
where categoryID = 2

 select * from products

