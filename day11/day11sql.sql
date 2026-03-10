create database day11;
use day11;
CREATE TABLE Company (emp_id INT PRIMARY KEY,emp_name VARCHAR(50),department VARCHAR(50),salary DECIMAL(10,2),city VARCHAR(50),join_date DATE);
select * from company;
drop table  company;

-- insert values
DELIMITER $$
CREATE PROCEDURE InsertEmp(IN id INT,IN name VARCHAR(50),IN dept VARCHAR(50),IN sal DECIMAL(10,2),IN city_name VARCHAR(50),IN jdate DATE)
BEGIN
    INSERT INTO Company
    VALUES(id, name, dept, sal, city_name, jdate);
END $$
DELIMITER ;
CALL InsertEmp(101,'Ravi','IT',60000,'Chennai','2023-05-10');
CALL InsertEmp(102,'loki','HR',90000,'Chennai','2024-08-10');
drop procedure insertemp;

-- display all
DELIMITER $$
CREATE PROCEDURE ShowEmployees()
BEGIN
    SELECT * FROM Company;
END $$
DELIMITER ; 
CALL ShowEmployees();
drop procedure ShowEmployees ;

--  find emp by dept
DELIMITER $$
CREATE PROCEDURE empbydept(IN dept_name VARCHAR(50))
BEGIN
    SELECT *
    FROM Company
    WHERE department = dept_name;
END $$
DELIMITER ;
CALL empbydept ('IT');

-- update sal
 DELIMITER $$
CREATE PROCEDURE UpdateSal(IN empid INT,IN new_salary DECIMAL(10,2))
BEGIN
    UPDATE Company
    SET salary = new_salary
    WHERE emp_id = empid;
END $$
DELIMITER ;
CALL UpdateSal(101,65000);

-- sal statistics
 DELIMITER $$
CREATE PROCEDURE SalStat()
BEGIN
    SELECT 
        AVG(salary) AS AvgSalary,
        MIN(salary) AS MinSalary,
        MAX(salary) AS MaxSalary,
        COUNT(emp_id) AS TotalEmployees
    FROM Company;
END $$
DELIMITER ;
CALL SalStat();
