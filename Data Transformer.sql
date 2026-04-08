-- Data Transformer Project
-- Author: Mayur
-- Concepts: Joins, Subqueries, Window Functions, CASE

drop database if exists project;

create database project;

use project;

create table customers(
	cust_id int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    reg_date date
);

truncate customers;
truncate orders;
drop table orders;

insert into customers values
(1, 'Arnav', 'Shah', 'arnav.shah@example.com', '2023-01-05'),
(2, 'Mira', 'Joshi', 'mira.joshi@example.com', '2023-02-14'),
(3, 'Kabir', 'Seth', 'kabir.seth@example.com', '2023-03-22'),
(4, 'Isha', 'Kapoor', 'isha.kapoor@example.com', '2023-04-01'),
(5, 'Rehan', 'Ali', 'rehan.ali@example.com', '2023-05-15'),
(6, 'Tanya', 'Singh', 'tanya.singh@example.com', '2023-06-10'),
(7, 'Varun', 'Patel', 'varun.patel@example.com', '2023-07-21'),
(8, 'Sara', 'Nair', 'sara.nair@example.com', '2023-08-09'),
(9, 'Dev', 'Bose', 'dev.bose@example.com', '2023-09-18'),
(10, 'Anya', 'Rao', 'anya.rao@example.com', '2023-10-25'),
(11, 'Raghav', 'Chopra', 'raghav.chopra@example.com', '2023-11-11'),
(12, 'Kiara', 'Mehta', 'kiara.mehta@example.com', '2023-12-01');


create table orders(
	orderid int primary key,
    cust_id int,
    orderdate date,
    totalamount decimal(10,2),
    foreign key (cust_id) references customers(cust_id)
);

insert into orders values
(201, 1,  '2024-01-10', 1800.00),
(202, 2,  '2024-01-15', 950.50),
(203, 3,  '2024-02-01', 400.00),
(204, 4,  '2024-02-12', 1200.75),
(205, 5,  '2024-03-03', 2600.00),
(206, 6,  '2024-03-15', 150.25),
(207, 7,  '2024-04-01', 730.10),
(208, 8,  '2024-04-22', 1750.00),
(209, 9,  '2024-05-10', 620.50),
(210, 10, '2024-05-28', 455.00),
(211, 11, '2024-06-05', 1450.99),
(212, 12, '2024-06-18', 810.20),
(213, 2,  '2024-07-01', 2100.00),
(214, 4,  '2024-07-12', 350.00),
(215, 5,  '2024-07-25', 500.00);

create table employees(
	emp_id int primary key,
    firstname varchar(50),
    lastname varchar(50),
    department varchar(50),
    hiredate date,
    salary decimal(10,2)
);

truncate employees;

insert into employees values
(1, 'Aarav', 'Khanna', 'Sales',     '2021-01-12', 38000),
(2, 'Diya',  'Sharma', 'Marketing', '2022-03-08', 52000),
(3, 'Vivaan','Patil',   'HR',       '2020-07-21', 61000),
(4, 'Meera', 'Iyer',    'Finance',  '2019-11-14', 78000),
(5, 'Zoya',  'Verma',   'IT',       '2022-01-05', 85000),
(6, 'Kabir', 'Desai',   'IT',       '2023-02-17', 64000),
(7, 'Ritu',  'Ghosh',   'Sales',    '2022-10-10', 42000),
(8, 'Farhan','Ali',     'HR',       '2023-05-29', 50000),
(9, 'Nisha', 'Reddy',   'Finance',  '2024-02-05', 70000),
(10,'Ayaan', 'Mehta',   'Marketing','2023-08-18', 55000),
(11,'John',  'Kapoor',  'Sales',    '2021-04-20', 45000);

-- q1

select o.*,concat(c.firstname,' ',c.lastname) as cust_name from orders o join customers c on o.cust_id=c.cust_id;

-- q2

select o.*,concat(c.firstname,' ',c.lastname) as cust_name from customers c left join orders o on c.cust_id=o.cust_id;

-- q3

select o.*,concat(c.firstname,' ',c.lastname) as cust_name from customers c right join orders o on c.cust_id=o.cust_id;

-- q4

select o.*,concat(c.firstname,' ',c.lastname) as cust_name from customers c left join orders o on c.cust_id=o.cust_id
union
select o.*,concat(c.firstname,' ',c.lastname) as cust_name from customers c right join orders o on c.cust_id=o.cust_id;

-- q5

select o.*,concat(c.firstname,' ',c.lastname) as cust_name from orders o join customers c on o.cust_id=c.cust_id where o.totalamount>(select avg(totalamount) from orders);

-- q6

select * from employees where salary>(select avg(salary) from employees);

-- q7

select orderid,orderdate,year(orderdate),month(orderdate) from orders;

-- q8

select orderid,orderdate,curdate(),datediff(curdate(),orderdate) as deff from orders;

-- q9

select orderid,orderdate,date_format(orderdate,'%d-%m-%Y') as new_formeat from orders;

-- q10
select firstname,lastname,concat(firstname,' ',lastname) as fullname from employees;

select firstname,lastname,concat(firstname,' ',lastname) as fullname from customers;

-- q11

select firstname,replace(firstname,'john','jonathan') as re from employees;

-- q12

select firstname,upper(firstname),lastname,lower(lastname) from employees;

-- q13

select cust_id,trim(email) from customers;

-- q14

select *,sum(totalamount) over(order by orderid) as run_total from orders;

-- q15

select *,rank() over(order by totalamount desc) as totalamount_rank from orders;

-- q16

select *,
case 
	when totalamount>1000 then totalamount-(totalamount*10/100)
    else totalamount-(totalamount*5/100)
end as discount
from orders;

-- q17 

select *,
case
	when salary>=60000 then 'high'
    when salary>=40000 then 'medium'
    else 'low'
end as salary_cate
from employees;