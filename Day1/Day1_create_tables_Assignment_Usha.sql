

create table categories
(categoryID int primary key, categoryName varchar(255),
description varchar(255)
);


select * from categories

	
create table customers (customerID
varchar(20) primary key, companyName
 varchar(255), 
 contactName varchar(100) not null, 
 contactTitle  varchar(100), 
 city varchar(25), 
 country varchar(25) not null
);


select * from customers

	
create table employees
(employeeID int primary key, 
employeeName varchar(255) not null,
title varchar(255),
city varchar(255),
country varchar(255),
reportsTo int);

select * from employees
	
create table products(
productID int primary key,
productName varchar(255),
quantityPerUnit varchar(255),
unitPrice float,
discontinued int,   
categoryID int references categories(categoryID));

select * from products
	
CREATE TABLE shippers(shipperID int primary key,
companyName  varchar(255)
);

select * from shippers
	

CREATE TABLE orders (
  orderID INT PRIMARY KEY,
  customerID VARCHAR(50) NOT NULL,
  employeeID INT NOT NULL,
  orderDate DATE,
  requiredDate DATE,
  shippedDate DATE,
  shipperID INT NOT NULL,
  freight double precision,
  FOREIGN KEY (customerID) REFERENCES customers(customerID),
  FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
  FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);


select * from orders
	
create table order_details(
orderID int references orders(orderID),
productID int references products(productID),
unitPrice float,
quantity int,
discount float,
primary key(orderID,productID));

select * from order_details

