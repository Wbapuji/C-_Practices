-- Create Database
CREATE DATABASE join_practice;

-- Use Database
USE join_practice;


-- =========================
-- TABLE 1: Employees
-- =========================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);


-- Insert data into Employees
INSERT INTO employees (emp_id, emp_name, dept_id, salary)
VALUES
(101, 'Ravi', 10, 50000),
(102, 'Priya', 20, 60000),
(103, 'Arun', 10, 55000),
(104, 'Sneha', 30, 65000),
(105, 'Kiran', NULL, 45000);


-- =========================
-- TABLE 2: Departments
-- =========================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


-- Insert data into Departments
INSERT INTO departments (dept_id, dept_name, location)
VALUES
(10, 'IT', 'Hyderabad'),
(20, 'HR', 'Chennai'),
(30, 'Finance', 'Bangalore'),
(40, 'Marketing', 'Mumbai');


-- =========================
-- CHECK THE DATA
-- =========================

SELECT * FROM employees;

SELECT * FROM departments;
select d.location, count(*) from employees e join departments d on e.dept_id=d.dept_id where d.location='Hyderabad' group by location ; 

select e.emp_name, e.salary, d.dept_name from employees e join departments d on e.dept_id=d.dept_id where d.dept_name='IT' order by e.salary desc limit 1; 

select e.*, d.* from employees e cross join departments d; 

SELECT emp_name, salary, dense_rank() over(partition by dept_id order by salary desc) as rk FROM employees;

SELECT
        emp_name,
        dept_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY dept_id
            ORDER BY salary DESC
        ) AS rn
    FROM employees;
    
    SELECT 
    e.emp_name, 
    e.salary,
    e.dept_id,
    DENSE_RANK() OVER (
        PARTITION BY dept_id 
        ORDER BY salary DESC
    ) AS rk 
FROM employees;


SELECT *
FROM (
    SELECT 
        e.emp_name, 
        e.salary,
        e.dept_id,
        DENSE_RANK() OVER (
            PARTITION BY dept_id 
            ORDER BY salary DESC
        ) AS rk 
    FROM employees e
) AS emp inner join departments d on emp.dept_id=d.dept_id where d.dept_name="IT" and emp.rk=2;

select emp_name, salary, 
dense_rank() over (partition by dept_name order by salary desc) as rk 
from (select e.*, d.dept_name, d.location from employees e 
join departments d on e.dept_id = d.dept_id) as emp where emp.rk = 2;

select e.*, d.* from employees e join departments d on e.dept_id = d.dept_id;


SELECT *
FROM (
    SELECT 
        e.emp_name, 
        e.salary,
        e.dept_id,
        DENSE_RANK() OVER (
            PARTITION BY e.dept_id 
            ORDER BY e.salary DESC
        ) AS rk 
    FROM employees e
) AS ranked_employees;
    
    
SELECT FROM () e inner join departments d on e.dept_id=d.dept_id where d.dept_name='IT' and e.rk=1;

select emp_name,emp_id,rk 
from (select emp_name,emp_id,salary,dense_rank() over
(order by salary desc) as rk from employees) as ranked where rk=3 ;

