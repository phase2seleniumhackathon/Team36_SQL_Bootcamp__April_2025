drop table if exists orders;
CREATE TABLE orders
(
    "orderID" integer NOT NULL,
    "customerID" text,
    "employeeID" integer,
    "orderDate" date,
    "requiredDate" date,
    "shippedDate" date,
    "shipperID" integer,
    "freight" numeric(10, 2),
    PRIMARY KEY ("orderID")
);

select * from orders

drop table if exists order_details;
CREATE TABLE order_details
(
	"orderID" integer NOT NULL,
	"productID" integer,
	"unitPrice" numeric(10, 2),
	"quantity" integer,
	"discount" numeric(10, 2),
	PRIMARY KEY ("orderID", "productID")
);

select * from order_details


DROP TABLE IF EXISTS customers;
CREATE TABLE customers
(
	"customerID" text,
	"companyName" text,
	"contactName" text,
	"contactTitle" text,
	"city" text,
	"country" text,
	PRIMARY KEY ("customerID")
);


select * from customers

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    "productID" INTEGER,
    "productName" TEXT,
    "quantityPerUnit" TEXT,
    "unitPrice" REAL,
    "discontinued" INTEGER, 
    "categoryID" INTEGER,
    PRIMARY KEY ("productID")
);

select * from products

drop table if exists categories;

CREATE TABLE categories
(
	"categoryID" integer,
	"categoryName" text,
	"description" text,
	PRIMARY KEY("categoryID")
);

select * from categories

drop table if exists employees
CREATE TABLE employees
(
	"employeeID" integer,
	"employeeName" text,
	"title" text,
	"city" text,
	"country" text,
	"reportsTo" integer,
	PRIMARY KEY("employeeID")
);

select * from employees

drop table if exists shippers
CREATE TABLE shippers
(
	"shipperID" integer,
	"companyName" text,
	PRIMARY KEY("shipperID")
);

select * from shippers