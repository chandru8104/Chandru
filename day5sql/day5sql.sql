create database day5;
use day5;

-- task 1--------------------------------------------------------------------------------------------------------------------------------------------------
 
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,CustomerName VARCHAR(50),City VARCHAR(50));
CREATE TABLE Products (ProductID INT PRIMARY KEY,ProductName VARCHAR(50),Price DECIMAL(10, 2));
CREATE TABLE Orders (OrderID INT PRIMARY KEY,CustomerID INT,ProductID INT,OrderDate DATE,Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

INSERT INTO Customers VALUES (1, 'Alice', 'New York'), (2, 'Bob', 'London'), (3, 'Charlie', 'Paris'), (4, 'David', 'Berlin');
INSERT INTO Products VALUES (101, 'Laptop', 1200.00), (102, 'Mouse', 25.00), (103, 'Keyboard', 50.00);
INSERT INTO Orders VALUES (1, 1, 101, '2023-01-01', 1), (2, 2, 102, '2023-01-02', 2), (3, 1, 103, '2023-01-03', 1), (4, NULL, 101, '2023-01-04', 1);

create table customers(customerId int primary key auto_increment,customerName varchar(50),city varchar(50));
create table customers(customerId int ,customerName varchar(50),city varchar(50),constraint ck_1 primary key auto_increment(customerId));
create table customers(customerId int, customerName varchar(50),city varchar(50),constraint ck_1 primary key auto_increment(customerId,customerName));


create table products (productId  int primary key auto_increment,productname varchar(50),price decimal(10,2));
create table products (productId int,productname varchar(50),price decimal(10,2),constraint ck_2 primary key auto_increment(productId));
create table products (productId int,productname varchar(50),price decimal(10,2),constraint ck_2 primary key auto_increment(productId,productname));


create table orders(orderid int primary key auto_increment,customerid int,productid int,orderdate date,quantity int,
foreign key(customerid) references customers(customerid),
foreign key (productid) references products(productid));
create table orders(orderid int,customerid int,productid int,orderdate date,quantity int,constraint ck_3 primary key auto_increment(orderid),
constraint ck_31 foreign key(customerid) references customers(customerid),constraint ck_32 foreign key(productid) references products(productid));



create table customers(customerId int unique auto_increment,customerName varchar(50),city varchar(50));
create table customers(customerId int ,customerName varchar(50),city varchar(50),constraint ck_1 unique auto_increment(custoomerId));
create table customers(customerId int, customerName varchar(50),city varchar(50),constraint ck_1 unique auto_increment(customerId,customerName));


create table products (productId  int unique auto_increment,productname varchar(50),price decimal(10,2));
create table products (productId int,productname varchar(50),price decimal(10,2),constraint ck_2 unique auto_increment(productId));
create table products (productId int,productname varchar(50),price decimal(10,2),constraint ck_2 unique key auto_increment(productId,productname));


create table orders(orderid int unique auto_increment,customerid int,productid int,orderdate date,quantity int,
foreign key(customerid) references customers(customerid),
foreign key (productid) references products(productid));
create table orders(orderid int,customerid int,productid int,orderdate date,quantity int,constraint ck_3 unique auto_increment(orderid),
constraint ck_31 foreign key(customerid) references customers(customerid),constraint ck_32 foreign key(productid) references products(productid));



alter table customers drop primary key;

alter table products drop foreign key productid;

alter table orders drop foreign key productid;

-- task 2------------------------------------------------------------------------------------------------------------------------------------------
 select * from Customers;
select * from Products;
select * from Orders;

select c.customername,o.orderid from customers c join orders o on  c.customerID=o.CustomerID;

select c.customername,o.orderid from customers c left join orders o on c.customerID=o.CustomerID;

select p.productname,o.orderid from products p left join orders o on p.ProductID=o.ProductID;

select c.customername,p.productname,o.orderdate from 
orders o join customers c on o.customerid=c.customerid 
join products p on o.productid=p.productid;

select c.customername, o.orderid from orders o join customers c on o.customerid=c.customerid join products p on o.productid=p.productid where p.productname="laptop";

select c.customername,c.customerid, p.price * o.quantity as totalmoney from orders o join customers c on o.customerid=c.customerid join products p on o.productid=p.productid ;

select p.productname from orders o left join products p on o.productid = p.productid left join customers c on o.customerid=c.customerid where c.customerid=null;

select c.customername,p.productname from customers c cross join products p;






