create database august;
show databases;
use  august;
create table users(
id int primary key auto_increment, name varchar(50) not null, email varchar(50) not null unique,
gender enum('male', 'female', 'others') , 
DOB date, createdTime timestamp default current_timestamp);
select * from users;
drop database prac;
select name,email from users;
rename table users to customers;
rename table customers to users;
alter table users add column is_active boolean default true;
select * from users;
alter table users modify column email varchar(150); 
describe users;
select COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA='august' and TABLE_NAME='users';
show create table users;
alter table users modify column email varchar(150) after id;
alter table users modify column is_active boolean first;
alter table users modify column is_active boolean after createdTime;
alter table users modify column email varchar(150) after name;
insert into users values
(1,'gopal','gopi@gmail.com','male' , '2003-01-19', default,true),
(2,'raju','raju@gmail.com','male', '2007-09-23', default, true);
truncate table users;
CREATE DATABASE IF NOT EXISTS startersql;
USE startersql;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary decimal(10,2),
    created_at timestamp default current_timestamp);
    select * from employees;
    INSERT INTO employees (name, email, gender, date_of_birth, salary) VALUES
('Aarav', 'aarav@example.com', 'Male', '1995-05-14', 65000.00),
('Ananya', 'ananya@example.com', 'Female', '1990-11-23', 72000.00),
('Raj', 'raj@example.com', 'Male', '1988-02-17', 58000.00),
('Sneha', 'sneha@example.com', 'Female', '2000-08-09', 50000.00),
('Farhan', 'farhan@example.com', 'Male', '1993-12-30', 61000.00),
('Priyanka', 'priyanka@example.com', 'Female', '1985-07-12', 84000.00),
('Aisha', 'aisha@example.com', 'Female', '1997-03-25', 56000.00),
('Aditya', 'aditya@example.com', 'Male', '1992-06-17', 69000.00),
('Meera', 'meera@example.com', 'Female', '1989-09-05', 77000.00),
('Ishaan', 'ishaan@example.com', 'Male', '2001-10-02', 45000.00),
('Tanvi', 'tanvi@example.com', 'Female', '1994-04-18', 62000.00),
('Rohan', 'rohan@example.com', 'Male', '1986-12-01', 75000.00),
('Zoya', 'zoya@example.com', 'Female', '1998-01-15', 54000.00),
('Karan', 'karan@example.com', 'Male', '1990-08-22', 68000.00),
('Nikita', 'nikita@example.com', 'Female', '1987-03-10', 71000.00),
('Manav', 'manav@example.com', 'Male', '1996-11-29', 61000.00),
('Divya', 'divya@example.com', 'Female', '1991-02-28', 57000.00),
('Harshit', 'harshit@example.com', 'Male', '1993-09-09', 65000.00),
('Ritika', 'ritika@example.com', 'Female', '1999-05-05', 52000.00),
('Imran', 'imran@example.com', 'Male', '1995-07-30', 63000.00),
('Juhi', 'juhi@example.com', 'Female', '1992-10-14', 59000.00),
('Tushar', 'tushar@example.com', 'Male', '1990-01-08', 73000.00),
('Lata', 'lata@example.com', 'Female', '1984-11-11', 78000.00),
('Yash', 'yash@example.com', 'Male', '1997-06-06', 64000.00),
('Fatima', 'fatima@example.com', 'Female', '1993-03-03', 55000.00);
select name,salary from employees where gender!='Female';
select name,salary from employees where date_of_birth<'2004-05-05' order by gender desc;
insert into employees(name,email,gender,date_of_birth,salary) values
('derek','derek@gmail.com','Male',null,64000.23);
select name,salary from employees where date_of_birth is null;
select name from employees where date_of_birth between '1999-01-01' and '2001-01-01';
select name from employees where gender in ('Male');
select * from employees where gender='Male' and salary>'54000';
select * from employees where gender='Female' and salary > '49000' order by date_of_birth asc limit 4;
select max(salary) as highestSalary from employees;
select salary from employees order by salary desc limit 1;
select * from employees where salary=(select max(salary) from employees); 
update employees set  salary=98000 where gender ='Male' and id>0;
select name,salary as increment from employees where gender='Male';
select distinct count(id) from employees;
update employees set name='gopal' where email='imran@example.com';
select name from employees where email='imran@example.com';
update employees set salary=salary+10000 where salary<50000 and id>0;
insert into employees (name,email,gender,date_of_birth,salary) values
('devans','devans@user.com','Other','1999-11-01',70000);
delete from employees where gender='Other' and id>0;
delete from employees where date_of_birth is null and id>0;
alter table employees add constraint unique_email unique(email);
alter table employees add constraint chk_dob check(date_of_birth>'1800-01-01');
describe employees;
alter table employees modify column name varchar(100) not null;
insert into employees (name,email,gender,date_of_birth,salary) values
("crates","crates@uyser.com","Other","1996-09-18",79000);
select * from employees where name="crates";
select count(*) from employees where gender="Male";
select  gender, min(salary) as minsalary, max(salary) as maxsalary from employees group by gender;
select sum(salary) as totalmensalary from employees where gender="Male";
select gender, avg(salary) as avgsalary from employees group by gender; 
select name,gender, length(name) as lenOfName from employees;
CREATE TABLE user_log (
id INT AUTO_INCREMENT,
user_id INT,
name VARCHAR(100),
created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
insert into user_log(user_id,name) values
(101,"gopi"),
(102,"raju"),
(103,"rahul");
select * from user_log;
select * from employees;
delete from employees where date_of_birth is null and id>0;
select * from employees where date_of_birth is null;
select name, upper(name) as loweredName, concat(name,"123") as userid , now() as time from employees;
select upper(name) as uppername, year(date_of_birth) as DOB from employees order by DOB asc;
select upper(name) as uppername, day(date_of_birth) as DOB from employees order by DOB asc;
select name, datediff(current_date(),date_of_birth) as noOfDays from employees;
select name, round(salary) as rounded, floor(salary) as floored, ceil(salary) as ceiled from employees;
select id,mod(id,2) as evenOdd from employees;
select name,gender, if(gender="Male","Yes","No") as maleCheck from employees; 
select name,gender, 
case when gender="Male" then "yes"
	else "No" end as MaleGenderCheck from employees;
    
show variables like "autocommit"; 
commit;
 select * from employees;   
 create table departments(
 id int primary key auto_increment,city varchar(50) not null,
 dep enum("IT","FINANCE","DELIVERY","MANAGEMENT"),
 user_id int, constraint fk_id foreign key(user_id) references employees(id) on delete restrict);
 select * from departments;
 INSERT INTO departments (id,city, dep, user_id)
VALUES
(1,'Hyderabad', 'IT', 1),
(2,'Chennai', 'FINANCE', 2),
(3,'Bangalore', 'DELIVERY', 3),
(4,'Mumbai', 'MANAGEMENT', 4),
(5,'Hyderabad', 'IT', 5),
(6,'Chennai', 'DELIVERY', 6),
(7,'Pune', 'FINANCE', 7),
(8,'Delhi', 'IT', 8),
(9,'Kolkata', 'MANAGEMENT', 9),
(10,'Vijayawada', 'DELIVERY', 10);
-- joins
select e.*,d.* from employees e inner join departments d on e.id=d.user_id;
select e.*,d.* from employees e
 left join departments d on e.id=d.user_id 
 where d.city='Hyderabad' and e.salary>70000;
 
 alter table employees add column reff_id int;
 update employees set reff_id=1 where id between 2 and 5;
 update employees set reff_id=2 where id in(6,8,10);
 update employees set reff_id=7 where id in(20,21,22,23,24,25);
 select e2.name as managerName 
from employees e1 inner join employees e2
on e1.id=e2.reff_id where e1.name="Ananya";
select * from employees; 
create table ipl(teams varchar(50) not null);
insert into ipl values("csk"),
("rcb"),("srh"),("mi");
select * from ipl;
select i1.teams, i2.teams from ipl i1 join ipl i2 on i1.teams<>i2.teams;
create view Winners as select teams from ipl;
select * from Winners;
show indexes from employees;
create index idx_gender on employees(gender);
drop index idx_gender on employees;
select gender from employees where date_of_birth="1984-11-11";
select * from employees where salary > (select avg(salary) from employees);
select id,name,reff_id from employees where reff_id in(select id from employees where salary>45000);
select name,(select avg(salary) from employees) as avg from employees;
select gender,avg(salary) as "avg", count(*) as "total" 
from employees group by gender having avg(salary)>56000; 
select reff_id,count(*) as totalReff 
from employees where reff_id is not null group by reff_id having count(*)>1;

delimiter &&
create procedure viewTable()
begin
	select * from employees;
   end&&
 delimiter ;
 call viewTable();
  select * from employees where name like "_o%"; 
  select name,id,salary,rk 
from(select name,id,salary,dense_rank() over
(order by salary desc) as rk from employees) as ranked where rk<=3 ;



