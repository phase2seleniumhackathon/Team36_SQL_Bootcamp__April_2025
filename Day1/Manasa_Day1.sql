create table categories
(categoryID int primary key,categoryName varchar(255),
description varchar(255));
SELECT * FROM categories



create table customers (customerID
varchar(20) primary key, companyName
 varchar(255), 
 contactName varchar(255) not null, 
 contactTitle  varchar(255), 
 city varchar(255), 
 country varchar(255) not null);
SELECT * FROM customers



create table employees
(employeeID int primary key, 
employeeName varchar(255) not null,
title varchar(255),
city varchar(255),
country varchar(255),
reportsTo int);
SELECT * FROM employees


create table products(
productID int primary key,
productName varchar(255),
quantityPerUnit varchar(255),
unitPrice float,
discontinued int,	
categoryID int references categories(categoryID));
SELECT * FROM  products


CREATE TABLE shippers(shipperID	int primary key,
companyName  varchar(255));
SELECT * FROM shippers


CREATE TABLE orders(
orderID INTEGER primary key,
customerID VARCHAR(255) references customers(customerID),
employeeID INT references employees(employeeID),
orderDate Date,
requiredDate Date,
shippedDate Date,
shipperID INT references shippers(shipperID),
freight FLOAT
);
SELECT * FROM orders



create table order_details(orderID int references orders(orderID),
productID int references products(productID),
unitprice float,
quantity int,
discount float,
primary key(orderID,productID));
SELECT * FROM 	order_details





