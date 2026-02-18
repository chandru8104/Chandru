create database day3;
use day3;
create table emp(eno int,ename varchar(50),desg char(3),salary int,deptno int);
insert into emp values(1000,'John','PRG',15000,10),(1001,'Johnson','ENG',25000,10),(1002,'Martin','HR',35000,20),(1003,'Joseph','MD',95000,10),
(1004,'Albert','MGR',50000,20),(1005,'Antony','PRG',20000,20),(1006,'Sam','ENG',18000,30),(1007,'Samuel','PRG',15000,30),
(1008,'Mary','GM',75000,30),(1009,'Lisy','ENG',25000,10),(1010,'Jensy','HR',25000,20);
insert into emp values(1011,'Mini','PRG',25000,30);
insert into emp values(1012,'Ben','ENG',30000,30);
insert into emp values(1013,'Cathrin','HR',25000,20);
insert into emp values(1014,'Philip','MGR',45000,30);
insert into emp values(1015,'Peter','ENG',15000,20);
insert into emp values(1016,'Joe','ENG',Null,20);
select *from emp;
-- arithmetic operators  + - * / %
select ename,salary,salary+1000 as 
"increment",salary-1000 as"decrement",salary*5 as"inc *5" from emp;
-- comparion opertors  =,<>,!=,<,>,<=,>=
select * from emp where eno>1010;
select * from emp where desg ='mgr';
select * from emp where salary<20000;
select eno,ename,desg from emp where eno<>1013;
select eno,ename from emp where eno!=1001;
select ename,salary where salary>=15000;
select ename, salary from emp where salary<=25000;

-- range operator-BETWEEN,NOT BETWEEN'
select eno,ename,salary from emp where salary between 15000 and 75000;
select eno,ename,salary from emp where salary not between 30000 and 50000;

-- list operator-IN,NOT IN'
select * from emp where desg in('mgr''tl''hr');
select * from emp where desg not in('mgr''tl''hr');

-- 'unknown values-is NULL,IS NOT NULL'
select * from emp where salary is null;
select * from empl where salary is not null;

-- 'logical operator-AND ,OR,NOT'
select  * from empl where salary >20000 and desg='ENG';
select * from empl where salary >20000 and desg='ENG'and deptno=10;

-- 'string operator LIKE,NOT LIKE'
select * from empl where ename  like 'b%';
select * from empl where ename  like '_a%';
select * from empl where ename  not like 'j%';
select * from empl where ename  like 'l%';
