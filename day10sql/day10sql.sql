create database day10;
use day10;

CREATE TABLE employees2 (emp_id INT PRIMARY KEY,emp_name VARCHAR(50),department VARCHAR(50),salary DECIMAL(10,2),city VARCHAR(50));
INSERT INTO employees2 VALUES
(101,'Ravi','IT',50000,'Chennai'),(102,'Anu','HR',40000,'Bangalore'),(103,'Kiran','IT',60000,'Chennai'),
(104,'Meena','Sales',45000,'Mumbai'),(105,'John','HR',42000,'Delhi');

select * from employees2;

-- unique index
CREATE UNIQUE INDEX idx_sal ON employees2(salary);  
SHOW INDEX FROM employees2; 


-- Composite index 
CREATE INDEX idx_dept_city ON employees2(department, city);
SHOW INDEX FROM employees2; 

SELECT * FROM employees
WHERE dept = 'IT' AND city = 'Chennai';

-- Create view showing only IT employees earning above 55,000.
CREATE VIEW it_high_salary AS
SELECT *
FROM employees
WHERE dept = 'IT' AND salary > 55000;

SELECT * FROM it_high_salary;

-- Create view for HR employee names only.
CREATE VIEW hr_employee_names AS
SELECT name
FROM employees
WHERE dept = 'HR';

SELECT * FROM hr_employee_names;

-- Update salary of Ravi to 55,000 using view.

UPDATE it_high_salary
SET salary = 55000
WHERE name = 'Ravi';
