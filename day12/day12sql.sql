create database day12;
use day12;

-- primary key
CREATE TABLE Product (product_id INT PRIMARY KEY,product_name VARCHAR(50),price INT);

-- unique key
CREATE TABLE Employee (emp_id INT,email VARCHAR(100) UNIQUE,department VARCHAR(50));

-- foreign key------------------------------------------------------------------------------------
 -- parent tble 
 CREATE TABLE Department (dept_id INT PRIMARY KEY,dept_name VARCHAR(50));
 -- connection table
 CREATE TABLE Staff (staff_id INT PRIMARY KEY,staff_name VARCHAR(50),dept_id INT,FOREIGN KEY (dept_id) REFERENCES Department(dept_id));

 -- not null
 CREATE TABLE Student (student_id INT,name VARCHAR(50) NOT NULL,age INT);
 
 -- check 
 CREATE TABLE Customer (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),age INT CHECK (age >= 18));
 
