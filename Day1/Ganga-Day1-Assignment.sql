Create table categories (
          categoryID int primary key,
		  categoryName varchar(100),
		  description varchar(100)
         );
select * from categories

create table customers(
              customerID varchar (50) primary key,
			  companyName varchar (100),
			  contactName varchar (100),
			  contactTitle varchar (100),
			  city varchar (100),
			  country varchar (100));

select * from customers

create table shippers (
       			shipperID int primary key,
				companyName varchar (100));

select * from shippers

create table employees(
		employeeID int primary key,
		employeeName varchar(100),
		title varchar(100),
		city varchar(100),
		country varchar(100),
		reportsTo int REFERENCES employees(employeeID));


select * from employees


create table orders (
		orderID int primary key,
		customerID varchar (100) references customers(customerID),
		employeeID int references employees(employeeID) ,
		orderDate date,
		requiredDate date,
		shippedDate date,
		shipperID int references shippers(shipperID),
		freight float);
select * from orders;


create table order_details(
			orderID int references orders(orderID) ,
			productID int references products(productID) ,
			unitPrice Decimal(10,2),
			quantity int ,
			discount decimal(5,2),
			primary key (orderID, productID)
			);


create table products(
			productID int primary key ,
			productName varchar(100),
			quantityPerUnit varchar(100),
			unitPrice Decimal(10,2),
			discontinued boolean,
			categoryID int references categories(categoryID));



create table data_dictionary (
			"Table" varchar(100),
			Field varchar(100),
			Description varchar(100));

		


			






