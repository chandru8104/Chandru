CREATE DATABASE companyDB;
USE companyDB;

-- TASK 1--------------------------------------------------------------------------------------------------------------------

CREATE TABLE orders (order_id INT PRIMARY KEY,product_name VARCHAR(50),price DECIMAL(10,2));
INSERT INTO orders VALUES(1, 'Laptop', 50000),(2, 'Mobile', 20000),(3, 'Laptop', 55000),(4, 'Tablet', 15000),(5, 'Mobile', 22000);
select count(*) from orders;
select sum(price) from orders;
select avg(price) from orders;
select min(price) from orders;
select max(price) from orders;
select product_name, SUM(price) FROM orders GROUP BY product_name;

-- task 2---------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (id INT PRIMARY KEY,name VARCHAR(50) NOT NULL,email VARCHAR(100),salary DECIMAL(10,2) DEFAULT 30000);
alter  table employees add constraint umail unique (email);
INSERT INTO employees (id, name, email, salary) VALUES(1, 'Arun', 'arun@gmail.com', 40000),(2, 'Priya	', 'priya@gmail.com', 35000),(3, 'Rahul', 'rahul@gmail.com', 30000),(4, 'Sneha', 'sneha@gmail.com', 45000),(5, 'Kiran', 'kiran@gmail.com', 38000);
DROP TABLE employees;
insert into employees values(1, 'Arun', 'arun@gmail.com', 40000);

-- task 3---------------------------------------------------------------------------------------------- 

create table products(id int primary key auto_increment,name varchar(35),price int);
alter table products add column quantity int;
alter table products rename column price to unit_price;
insert into products(name,unit_price,stock)values('iphone',40000,5),
('samsung',30000,8),
('redmi',35000,4),
('one plus',50000,3),
('xioami',20000,7);
update products set stock=10 where id=4;
select * from products;

delete from products where id=5;
select * from products;
