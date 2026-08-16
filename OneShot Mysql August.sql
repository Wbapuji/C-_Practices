use august;
CREATE TABLE employes (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT,
    manager_id INT
);

INSERT INTO employes
    (employee_id, employee_name, department, salary, manager_id)
VALUES
    (101, 'Aarav', 'Engineering', 95000, 105),
    (102, 'Meera', 'Engineering', 72000, 105),
    (103, 'Kabir', 'Sales', 65000, 106),
    (104, 'Isha', 'Sales', 92000, 106),
    (105, 'Rohan', 'Engineering', 90000, NULL),
    (106, 'Neha', 'Sales', 88000, NULL);
    
    select * from employes;
    select employee_name,salary
    from employes where department="Engineering" order by salary desc;
    
    select department,count(*) as total_count from
    employes group by department having count(*) >2;
    
    select employee_name,salary,rk from
    (select employee_name,salary, dense_rank() over(
    order by salary desc
    ) as rk from employes
    ) as ranked  where rk=2;
    
     select employee_name, salary from employes
     where salary>(select avg(salary) from employes) ;
     
     select department, max(salary) as highest_salary
     from employes group by department;
    
     select e.employee_name,e.salary,m.employee_name as manager_name
    from employes e inner join employes m on e.manager_id=m.employee_id
    where e.salary>m.salary;
    CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, city)
VALUES
-- (1, 'Aditi Sha-- rma', 'Delhi'),
-- (2, 'Rahul Verma', 'Mumbai'),
-- (3, 'Simran Kaur', 'Chandigarh'),
-- (4, 'Arjun Nair', 'Bengaluru'),
(5, 'Aditi Sharma', 'Hyd');
    
    CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    status VARCHAR(20),
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
INSERT INTO orders (order_id, customer_id, amount, status)
VALUES
(501, 1, 2400, 'Delivered'),
(502, 1, 3200, 'Delivered'),
(503, 2, 1800, 'Delivered'),
(504, 2, 4100, 'Pending'),
(505, 3, 950, 'Cancelled');
    
    select c.customer_name,o.order_id from 
    customers c inner join orders o
    on c.customer_id=o.customer_id;
    
    select c.customer_id from
    customers c join orders o on
    c.customer_id=o.customer_id group by c.customer_id
    having count(*)>1; 
    
select * from customers where customer_name in (select c.customer_name from
    customers c join orders o on
    c.customer_id=o.customer_id group by c.customer_name
    having count(*)>1);
    
    select c.customer_id, sum(o.amount) as total from customers c join orders o 
    on c.customer_id=o.customer_id where status="Delivered"
    group by c.customer_id order by total desc;
    
    
    select customer_id, total, dense_rank() over(order by total desc) as rk from (select c.customer_id, sum(o.amount) as total from customers c join orders o 
    on c.customer_id=o.customer_id where status="Delivered"
    group by c.customer_id order by total desc) AS emp;
    
    select customer_id from (select customer_id, total, dense_rank() over(order by total desc) as rk from (select c.customer_id, sum(o.amount) as total from customers c join orders o 
    on c.customer_id=o.customer_id where status="Delivered"
    group by c.customer_id order by total desc) AS emp) as em where rk = 1;
    
    select * from customers where customer_id in (select customer_id from (select customer_id, total, dense_rank() over(order by total desc) as rk from (select c.customer_id, sum(o.amount) as total from customers c join orders o 
    on c.customer_id=o.customer_id where status="Delivered"
    group by c.customer_id order by total desc) AS emp) as em where rk = 1);
    
    
    create user tagore;
    SELECT User, Host FROM mysql.user;
    
    
    
    select c.*, COALESCE(o.order_id,'Not Available') as order_id, o.amount, o.status from customers c left join orders o 
    on c.customer_id=o.customer_id;
    --
		select * from customers where city in("Delhi");
		select * from orders where amount>2000;
        select * from customers where customer_name  like "A%";
        select * from orders where status="Delivered";
        select * from orders order by amount desc;
        select max(amount) from orders;
        select sum(amount) as totalamount from orders;
        select avg(amount) as avgamount from orders;
        select c.customer_name,o.order_id,o.amount from customers c join
        orders o on c.customer_id=o.customer_id;
        select c.customer_name,c.city,o.order_id,o.amount from customers c join
        orders o on c.customer_id=o.customer_id;
        select c.* from customers c left join orders o 
        on c.customer_id=o.customer_id;
         select c.* from customers c left join orders o 
        on c.customer_id=o.customer_id where o.order_id is not null;
        select distinct c.* from customers c 
        join orders o on c.customer_id=o.customer_id;
        SELECT c.customer_id, c.customer_name, c.city
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

select o.* , c.customer_name from customers c right join orders o 
on c.customer_id=o.customer_id;
select c.* from customers c join orders o
on c.customer_id=o.customer_id where o.status="Pending";

select c.* from customers c left join orders o on
c.customer_id=o.customer_id ;

        select c.* from customers c 
        where c.customer_id not in(
        select o.customer_id from 
        orders o
        where o.customer_id is not null
        );
        
        
        
        
    --
    CREATE TABLE User_Logins (
    user_id INT,
    login_date DATE,
    session_minutes INT
);

INSERT INTO User_Logins (user_id, login_date, session_minutes)
VALUES
(1, '2024-07-01', 35),
(1, '2024-07-02', 42),
(1, '2024-07-03', 28),
(2, '2024-07-01', 20),
(2, '2024-07-03', 25),
(3, '2024-07-02', 45);
select user_id, login_date, lag(login_date) over(partition by user_id order by login_date) as prev_login_date from User_Logins;

CREATE TABLE sale (
    employee_name VARCHAR(50),
    sale_date DATE,
    sale_amount DECIMAL(10,2)
);

INSERT INTO sale (employee_name, sale_date, sale_amount)
VALUES
('Bob',   '2024-01-02', 150),
('Carol', '2024-01-03', 200),
('Alice', '2024-01-01', 100),
('David', '2024-01-04', 120),
('Eva',   '2024-01-05', 180);

SELECT
    employee_name,
    sale_date,
    sale_amount from sale;

SELECT
    employee_name,
    sale_date,
    sale_amount,
    AVG(sale_amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM sale;
