create table categories
(categoryID int primary key,categoryName varchar(255),
description varchar(255)
);

select * from categories;

create table customers (customerID
varchar(20) primary key, companyName
 varchar(255), 
 contactName varchar(255) not null, 
 contactTitle  varchar(255), 
 city varchar(255), 
 country varchar(255) not null
);

select * from customers;


create table products(
productID int primary key,
productName varchar(255),
quantityPerUnit varchar(255),
unitPrice float,
discontinued int,	
categoryID int references categories(categoryID));

select * from products;

CREATE TABLE shippers(shipperID int primary key,
companyName  varchar(255)
);

select * from shippers;

create table employees
(employeeID int primary key, 
employeeName varchar(255) not null,
title varchar(255),
city varchar(255),
country varchar(255),
reportsTo int);

select * from employees;

CREATE TABLE orders(
orderID INTEGER primary key,
customerID VARCHAR(255),
employeeID INT references employees(employeeID),
orderDate Date,
requiredDate Date,
shippedDate Date,
shipperID INT references shippers(shipperID),
freight FLOAT
);

select * from orders;

create table order_details(orderID int references orders(orderID),
    productID int references products(productID),
    unitprice float,
    quantity int,
    discount float,
    primary key(orderID,productID));
select * from order_details;