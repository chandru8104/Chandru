create database day7;
use day7;
CREATE TABLE students1 (id INT,class VARCHAR(10),name VARCHAR(50),marks INT);
INSERT INTO students1 VALUES(1, 'A', 'John', 85),(2, 'A', 'Sara', 92),(3, 'A', 'Mike', 78),(4, 'B', 'Anna', 88),(5, 'B', 'Tom', 90);

CREATE TABLE exam1 (student VARCHAR(50),subject VARCHAR(20),score INT);
INSERT INTO exam1 VALUES('Alice', 'Math', 90),('Bob', 'Math', 90),('Charlie', 'Math', 85),('David', 'Science', 88),('Eva', 'Science', 88);

CREATE TABLE employees11 (emp_name VARCHAR(50),department VARCHAR(20),salary INT);
INSERT INTO employees11 VALUES('Alex', 'IT', 7000),('Brian', 'IT', 7000),('Chris', 'IT', 6500),('Diana', 'HR', 6000),('Eva', 'HR', 5800);

CREATE TABLE orders (order_id INT,order_date DATE, amount INT);
INSERT INTO orders VALUES(1, '2024-01-01', 100),(2, '2024-01-02', 200),(3, '2024-01-03', 150),(4, '2024-01-04', 300);

CREATE TABLE monthly_sales (month VARCHAR(10), sales INT);
INSERT INTO monthly_sales VALUES('Jan', 5000),('Feb', 6000),('Mar', 5500),('Apr', 7000);


-- 1. Assign a unique row number to students in each class based on highest marks:

select name,class,marks, row_number() over (partition by class order by marks desc)as row_no from students1;

-- -- 2.Rank students in each class based on marks (with gaps).

select name,class,marks, rank() over (partition by class order by marks desc) as row_no from students1;

-- -- 3. Rank students in each class based on marks (without gaps).

select name,class,marks, dense_rank() over (partition by class order by marks desc) as ranks from students1;

-- -- 4. Display average marks of each class along with every student.

select distinct(class),avg(marks) over (partition by class) as class_avg from students1;

-- 5. Show the highest marks scored in each class for every student.

select distinct(class),max(marks) over (partition by class) as Max_marks from students1;

-- 6. Assign row numbers to students per subject based on score.

select student,subject,score, row_number() over (partition by subject order by score desc) as score from exam1;

-- 7.Rank students per subject (with gaps).

select student,subject, rank() over (partition by subject order by score) as row_with_gaps from exam1;

-- 8.Rank students per subject (without gaps).

select student,subject, dense_rank()over (partition by subject order by score) as row_without_gaps from exam1;

-- 9. Show total number of students appearing in each subject.

select distinct(subject) ,count(student) over (partition by subject ) as STUDENTS from exam1;

-- 10. Display the minimum score for each subject.

select distinct(subject),min(score) over (partition by subject) as Min_score from exam1;

-- 11. Assign row numbers to employees per department by salary.

select emp_name,department,salary, row_number() over(partition by department order by salary) as Row_num from employees11;

-- 12. Rank employees per department based on salary.

select emp_name,department,salary, rank() over (partition by department order by salary desc) as RANKS from employees11;

-- 13. Rank employees per department without gaps.

select emp_name,department,salary, dense_rank() over (partition by department order by salary desc) as Ranks from employees11;

-- 14. Show total salary paid in each department.

select distinct(department),sum(salary) over (partition by department ) as Total_salaries from employees11;

-- 15. Display average salary of each department.

select distinct(department),avg(salary) over (partition by department ) as Average_salaries from employees11;

-- 16. Assign row numbers based on order date.

select order_id,order_date, row_number() over (order by order_date) as Orders from orders;

-- 17. Calculate running total of order amounts.

select order_id,order_date,sum(amount) over (order by order_date) as Totals from orders;

-- 18. Calculate moving average of last 2 orders.

select order_id,amount,avg(amount) over (order by order_date rows between 1 preceding and current row) as moving_avg from orders;

-- 19. Show maximum order amount till current row.

select order_id,order_date,amount,max(amount) over (order by order_date ) as Order_running from orders;

-- 20. Display total number of orders.

select distinct(count(order_id)over (order by order_id)) as Total_orders from orders;

-- 21. Assign row numbers based on month.

select month,sales, row_number() over ( order by month) as new_row from monthly_sales;

-- 22. Show previous month’s sales.

select month,sales,lag(sales) over(order by month) as previous_sales from monthly_sales;

-- 23. Show next month’s sales.

select month,sales,lead(sales) over (order by month) as Next_sales from monthly_sales;

-- 24. Calculate difference from previous month’s sales.

select month,sales,sales-lag(sales) over (order by month) as Diff from monthly_sales;

--  25. Calculate cumulative sales.

select month , sales,sum(sales) over(order by month) as cum_sales from monthly_sales;
