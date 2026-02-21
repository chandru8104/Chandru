create database day6;
use day6;

CREATE TABLE departments (dept_id INT,dept_name VARCHAR(50));
CREATE TABLE employees (emp_id INT,emp_name VARCHAR(50),dept_id INT,manager_id INT,salary INT);
CREATE TABLE projects (project_id INT,project_name VARCHAR(50),dept_id INT);
CREATE TABLE emp_projects (emp_id INT,project_id INT);
CREATE TABLE locations (location_id INT,dept_id INT,city VARCHAR(50));

INSERT INTO departments VALUES(1, 'IT'),(2, 'HR'),(3, 'Finance'),(4, 'Sales');
INSERT INTO employees VALUES(1, 'Alice', 1, NULL, 80000),(2, 'Bob', 1, 1, 60000),(3, 'Charlie', 2, 1, 50000),(4, 'David', 3, 2, 70000),(5, 'Eva', NULL, 2, 45000);
INSERT INTO projects VALUES(101, 'Website', 1),(102, 'Payroll', 3),(103, 'Recruitment', 2);
INSERT INTO emp_projects VALUES(1, 101),(2, 101),(3, 103),(4, 102);
INSERT INTO locations VALUES(1, 1, 'New York'),(2, 2, 'London'),(3, 3, 'Tokyo');
-- subquery-------------------------------------------------------

select * from employees where salary>(select avg(salary) from employees); 

select * from employees where dept_id = (select dept_id from departments where dept_name="IT");

select emp_name from employees where salary=(select max(salary) from employees);    

select * from employees where emp_id=(select emp_id from employees where dept_id is null); 

select * from employees where dept_id in(select dept_id from projects where project_name is not null);  

select emp_name,emp_id from employees where emp_id not in (select emp_id from emp_projects); 

select dept_name from departments where dept_id in (select dept_id from employees where dept_name is not null);

select dept_name from departments where dept_id not in (select dept_id from employees where dept_id is not null); 

select e.emp_name from employees e where e.salary>(select m.salary from employees m where m.emp_id=e.manager_id); 

select emp_name from employees where dept_id = (select dept_id from locations where city = 'tokyo'); 

select emp_name from employees where dept_id = (select dept_id from projects where project_name="website"); 

select project_name from projects where dept_id=(select dept_id from departments where dept_name="IT");  

select emp_name from employees where emp_id in ( select emp_id from employees where manager_id is not null); 

select emp_name from employees where emp_id in (select emp_id from employees where manager_id is null);   

select dept_name from departments where dept_id in (select dept_id from projects where project_name is not null);  

select dept_name from departments where dept_id not in(select dept_id from projects); 

select e.emp_name , e.salary from employees e where e.salary>(select avg(e2.salary) from employees e2 where e2.dept_id=e.dept_id);  

select emp_name,salary from employees where salary=(select max(salary) from employees where salary < (select max(salary) from employees)); 

select emp_name from employees where dept_id in (select dept_id from employees group by dept_id having count(*) > 1); 

select emp_name from employees where dept_id in(select dept_id from locations where city is not null);

select emp_name from employees where dept_id not in(select dept_id from locations); 
