create database day8;
use day8;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    AddressLine VARCHAR(150),
    City VARCHAR(50),
    State VARCHAR(50),
    zipCode VARCHAR(20),
    RegistrationDate DATE
);
INSERT INTO Customers 
(FirstName, LastName, Email, Phone, AddressLine, City, State, zipCode, RegistrationDate)
VALUES
('Rahul', 'Sharma', 'rahul@gmail.com', '9876543210', '12 MG Road', 'Chennai', 'TN', '600001', '2024-01-15'),
('Priya', 'Kumar', 'priya@gmail.com', '9876501234', '45 Anna Nagar', 'Chennai', 'TN', '600040', '2024-03-10'),
('Arun', 'Raj', NULL, '9000011111', '78 Lake View', 'Bangalore', 'KA', '560001', '2024-05-20'),
('Meena', 'Ravi', 'meena@gmail.com', '9888877777', '23 Park Street', 'Mumbai', 'MH', '400001', '2024-06-25');

-- Create a stored procedure to add a new customer.

delimiter $$
create procedure addcustomer(IN p_FirstName VARCHAR(50),IN p_LastName VARCHAR(50),IN p_Email VARCHAR(100))
begin
		insert into customers (firstname,lastname,email,phone,addressline,city,state,zipcode,registrationdate) values ('chandru','sharma','c@gamil.com','419747932','12 MG Road', 'Chennai', 'TN', '600001', '2024-01-15');
end$$
delimiter ;

call addcustomer('chandy','chandru','rahul@gmail.com');
select *from customers;

-- Create a stored procedure to retrieve customer details by CustomerID.
delimiter //
CREATE PROCEDURE GetCustomerByID (CustomerID INT)
BEGIN
    SELECT * FROM Customers WHERE CustomerID = CustomerID;
END//
delimiter ;

call getcustomerbyid(1);
call getcustomerbyid(2);

-- Create a stored procedure to update a customer's email and phone number. 
drop procedure update_email;
delimiter //
create procedure update_email(in p_email varchar(20),in p_phone int,in p_customerid int)
begin
update customers set email=p_email,phone=p_phone where customerid=p_customerid;
end//
delimiter ;

call update_email('hemach81@gmail.com',9517065162,2);
set sql_safe_updates=0;

-- Create a stored procedure to get all customers from a specific city. 
delimiter //
create procedure specific_city(in p_city varchar(20))
begin
select * from customers where city=p_city;
end// 
delimiter ;

call specific_city('chennai');

-- Create a stored procedure to delete a customer by CustomerID. 
delimiter //
create procedure delete_customer(in p_customerid int)
begin
delete from customers where customerid=p_customerid;
end//
delimiter ;

call delete_customer(3);
drop procedure delete_customer;
-- Create a stored procedure to search for customers by partial FirstName or LastName.

delimiter //
create procedure searchcustomer(in p_name varchar(20))
begin
select * from customers where firstname like concat('%',p_name,'%')
or lastname like concat('%',p_name,'%');
end//
delimiter ;

call searchcustomer('y');

-- Create a stored procedure that returns the total number of customers.
delimiter //
create procedure get_total()
begin
select count(*) as totalcustomers from customers;
end//
delimiter ;

call get_total();

-- Create a stored procedure to retrieve customers who have not provided an email address.
delimiter //
create procedure get_customer()
begin
select * from customers where email is null;
end//
delimiter ;

call get_customer(); 
