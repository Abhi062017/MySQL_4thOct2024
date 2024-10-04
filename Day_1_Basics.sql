-- -- ******************************************************DAY 01 : 1st Oct 2024*********************************************************************************** -- 
/*
Day#1: Oct 1st, 2024
*/
select 5*9 from dual;

-- Use the "Help" command to know more about any SQL function/statement
help concat;

show databases; -- shows all the databses on server
create database testoct2024_1;

-- creating and dropping a test database
create database test2024;
drop database test2024;

show databases;

use testoct2024_1; -- allows you to get into a database, and all the actions performed are saved under this database
show tables;  -- shows all the tables created in the current database

create table emp
(emp_ID int,
 first_name varchar(50),
 last_name varchar(50),
 emp_age int,
 empZone varchar(50));

desc emp;
select * from emp;

-- Insert records 
insert into emp
values
(1, 'Ram','Sharma',25,'Gurugram'),
(2, 'Ben','Schrute',45,'Noida'),
(3, 'Arthur','Smith',29,'Delhi'),
(4, 'Mohan','Sharma',22,'Mumbai'),
(5, 'Shyam','Sharma',35,'Noida');

-- Delete records 
truncate table emp;  -- deletes all records but keeps the structure of the table in the database. So, new records can be added.
drop table emp; -- deletes the table completely, without keeping the structure of the table in the database. So, new records can't be added, as the table doesn't exist anymore.

set sql_safe_updates=0;

delete from emp
where emp_id = 1;

select last_name from emp; -- 5 values
select distinct(last_name) from emp;  -- 3 values
select count(last_name) from emp; -- 5 values
select count(distinct(last_name)) from emp; -- 3 values

alter table emp
rename to emp_test1;

alter table emp_test1
rename to emp;

select * from emp;

create table emp_test
(emp_ID int NOT NULL,
 first_name varchar(50),
 last_name varchar(50),
 emp_age int,
 empZone varchar(50));
 
desc emp_test;

select * from emp_test;

create table emp_test2
(emp_ID int primary key,
 first_name varchar(50),
 last_name varchar(50),
 emp_age int,
 empZone varchar(50));

desc emp_test2;

create table emp_test3
(emp_ID int primary key,
 first_name varchar(50),
 last_name varchar(50),
 emp_age int,
 empZone varchar(50),
 emp_ldap varchar(20) not null unique);

desc emp_test3;

create table dept_test1
(dept_ID int primary key,
 dept_name varchar(50),
 emp_ID int,
 foreign key(emp_ID) references emp_test3(emp_ID));
 
 desc dept_test1; -- Foreign key column can have nulls as well as multiple values, as opposed to Primary key's
 
 drop table dept_test1; -- dropping the table to create it again
 
 desc emp_test2;
 
 create table dept_test1
 (dept_ID int primary key,
  dept_name varchar(50),
  emp_ID int,
  foreign key(emp_ID) references emp_test2(emp_ID));

desc dept_test1;

-- auto_increment, unique, boolean
create table test1
 (test_ID int auto_increment primary key,
  test_name varchar(50),
  test_time datetime default current_timestamp, -- The valid range for DATETIME is from 1000-01-01 00:00:00 to 9999-12-31 23:59:59.
  test_date date not null, -- The valid range for DATE is from '1000-01-01' to '9999-12-31'.
  is_test_today boolean not null default true,  -- The BOOLEAN datatype is intended to represent two states: true (1) and false (0). Some databases also allow a third state, NULL, to indicate an unknown or undefined value.
  test_value int unique);
  
desc test1;
select * from test1;

insert into test1 (test_date)  -- since only test_date column has effective not null constraint, rest can take nulls or defaults, hence only entering value for one column : test_date
values ('2024-10-01');
  
insert into test1 (test_name, test_date, test_value)
values ('Bio','2012-02-19',1);

insert into test1 (test_name, test_date, test_value)
values ('Chem','2012-02-11',1); -- errors out for violating unique key contraint of test_value column

insert into test1 (test_name, test_date, test_value)
values ('Phy','2014-02-19',2),
	   ('Sci','2015-02-19',3);


select * from test1;


-- All about delete sttement
delete from test1; -- deletes all rows, but keep the table structure intact, just like truncate

delete from test1
where test_value = 3; -- deletes specific row

truncate table test1; -- same as row#124
drop table test1;  -- removes the table completely

create table test2
 (test_ID int auto_increment primary key,
  test_name varchar(50),
  test_time datetime default current_timestamp, -- The valid range for DATETIME is from 1000-01-01 00:00:00 to 9999-12-31 23:59:59.
  test_date date not null, -- The valid range for DATE is from '1000-01-01' to '9999-12-31'.
  is_test_today boolean not null default true,  -- The BOOLEAN datatype is intended to represent two states: true (1) and false (0). Some databases also allow a third state, NULL, to indicate an unknown or undefined value.
  test_value int unique,
  test_age int not null check(test_age>=18));

desc test2;
drop table test2;
  
insert into test2 (test_name, test_date, test_value, test_age)
values ('Bio','2012-02-19',5,19);

select * from test2;

insert into test2 (test_name, test_date, test_value, test_age)
values ('Science','2010-01-01',2,17);  -- check constrinat violated of the test_age column

insert into test2 (test_name, test_date, test_value)
values ('Science','2010-01-01',3);  -- not null constrinat violated of the test_age column

create table test3
 (test_ID int auto_increment primary key,
  test_name varchar(50),
  test_time datetime default current_timestamp, -- The valid range for DATETIME is from 1000-01-01 00:00:00 to 9999-12-31 23:59:59.
  test_date date not null, -- The valid range for DATE is from '1000-01-01' to '9999-12-31'.
  is_test_today boolean not null default true,  -- The BOOLEAN datatype is intended to represent two states: true (1) and false (0). Some databases also allow a third state, NULL, to indicate an unknown or undefined value.
  test_value int unique,
  test_age int check(test_age>=18));

desc test3;
drop table test3;
  
insert into test3 (test_name, test_date, test_value, test_age)
values ('Bio','2012-02-19',5,19);

select * from test3;

insert into test3 (test_name, test_date, test_value, test_age)
values ('Science','2010-01-01',2,17);  -- check constrinat violated of the test_age column

insert into test3 (test_name, test_date, test_value)
values ('Science','2010-01-01',3);  -- since not null is not added as constrinat for column test_age, the null value is accepted.

alter table test3 -- adding a column to an existing table
add test_centre varchar(50);

desc test3;

alter table test3
modify column test_centre char; -- modifying the column's data-type

alter table test3
drop column test_Centre;  -- dropping a column (Note : column name is also case insensitive)

desc test3;

select * from test3;

update test3  -- DML statement to update values of an existing record
set test_name = 'Chemistry', test_date = '2024-10-01'
where test_ID = 2;

truncate table test3;

insert into test3 (test_name,test_date) -- inserting multiple values to test the update statement
values ('Maths','2018-02-02'),
		('Bio','2029-02-02'),
        ('Physics','2020-02-02'),
		('Chemistry','2021-02-02'),
        ('English','2022-02-02'),
		('Hindi','2022-02-02');

select * from test3;

-- incorrect update statement to update multiple records (changing test_name and test_date of more than one test_IDs)
update test3  -- DML statement to update values of an existing record
set test_name = 'Nuclear Science', test_date = '2030-01-01'
set test_name = 'Astro Science', test_date = '2040-01-01'
where test_ID IN (5,6);


-- correct statement to update multiple records : 
Update test3
Set test_name = case
				when test_ID = 5 then "Nuclear Science"  -- Note : If there are spaces in a string then use double quotes
				when test_ID = 6 then "Astro Science"
				end,
	test_date = case
				when test_ID = 5 then '2030-01-01'
                when test_ID = 6 then '2040-01-01'
                end
where test_ID IN (5,6);

select * from test3;

-- order by clause
select test_name, test_ID
from test3
order by test_name;

select test_name, test_ID
from test3
order by test_name desc;  -- returns ordered by column in descending order

select test_ID, test_name -- position of column changes basis where you place the column names
from test3
order by test_name;

-- Limit clause
select * from test3; -- returns all records
select * from test3  -- returns top 3
Limit 3;

-- Alias and concat
show tables;  -- shows all the tables created in the current database
select * from emp
order by emp_ID;

select Emp_ID, concat(first_name,' ',last_name) as Full_Name from emp
order by emp_id;

help concat;

-- ******************************************************DAY 02 : 2nd Oct 2024*********************************************************************************** -- 
/*
Day#2: Oct 2nd, 2024
*/

-- Add Indexes, show index, delete index, Joins, sakila database

show schemas;
show databases;

drop schema sakila;
drop database sakila;

use testoct2024_1;
show tables;

use sakila;
show tables;

select * from sakila.actor
limit 5;


/*Question#1 : Return all pg-13 films with rental rate of <= $2.99
*/

select sakila.film.title, sakila.film.rating, sakila.film.rental_rate from sakila.film
where sakila.film.rating = 'PG-13' AND sakila.film.rental_rate <= 2.99;

with cte_film as
	(select sakila.film.title, sakila.film.rating, sakila.film.rental_rate from sakila.film
	where sakila.film.rating = 'PG-13' AND sakila.film.rental_rate <= 2.99)                      -- Notice the AND operator
select count(*) from cte_film;

with cte_film2 as
	(select sakila.film.title, sakila.film.rating, sakila.film.rental_rate from sakila.film
	where sakila.film.rating = 'PG-13' OR sakila.film.rental_rate <= 2.99)                       -- Notice the OR operator
select count(*) from cte_film2;

/*Question#2 : Return all the films with deleted scenes
*/
select sakila.film.special_features from sakila.film;

select count(distinct(sakila.film.special_features)) from sakila.film;

select sakila.film.special_features from sakila.film
where sakila.film.special_features LIKE '%Deleted Scenes%';

with cte_features as 
	(select sakila.film.special_features from sakila.film
	where sakila.film.special_features LIKE '%Deleted Scenes%')
select count(*) from cte_features;

select f.special_features from sakila.film f  -- alias the name of table as f
where f.special_features LIKE '%Deleted Scenes%';

/*Question#3 : Return all the active customers
*/
select * from sakila.customer;
select * from sakila.customer c
where c.active = 1;

select count(*) from sakila.customer c
where c.active = 1;

select concat(sakila.customer.first_name,' ', sakila.customer.last_name) as 'Full_Name' from sakila.customer
where sakila.customer.active=1; -- active customers count

select concat(sakila.customer.first_name,' ', sakila.customer.last_name) as 'Full Name' from sakila.customer
where sakila.customer.active=0;  -- inactive customers count

/*Question#4 : Name of the customers who rented movies on 26th July 2005
*/

select * from sakila.rental
join sakila.customer on sakila.customer.customer_id = sakila.rental.customer_id
where date(sakila.rental.rental_date) = '2005-07-26';

select * from sakila.rental
join sakila.customer on sakila.rental.customer_id = sakila.customer.customer_id
where date(sakila.rental.rental_date) = '2005-07-26';


select * from sakila.rental;
select * from sakila.customer;

select count(*) from rental;
desc rental; -- return_date is a datetime datatype and can accept null values, default is set to null
select distinct(sakila.customer.customer_id) from sakila.customer; -- all are unique values since it's a PK column

select sakila.rental.return_date from sakila.rental;
select count(sakila.rental.return_date) from sakila.rental;

desc sakila.customer;

select * from sakila.rental
where return_date='2005-07-26';

with cte_Q3 as 
	(select concat(sakila.customer.first_name,' ', sakila.customer.last_name) as 'Full Name', sakila.customer.customer_id from sakila.customer)
select * from cte_q3;

with cte_Q3 as 
	(select concat(sakila.customer.first_name,' ', sakila.customer.last_name) as 'Full Name', sakila.customer.customer_id from sakila.customer)
select count(*) from cte_q3;

with cte_rental3 as 
	(select sakila.rental.customer_id, sakila.rental.rental_date from sakila.rental)
select * from cte_rental3;

-- select c.customer_id, c.first_name from sakila.customer c
-- join sakila.rental 

select * from sakila.customer
join sakila.rental on sakila.rental.customer_id=sakila.customer.customer_id
where date(sakila.rental.rental_date)='2005-07-26';
 
select concat(sakila.customer.first_name,' ',sakila.customer.last_name) from sakila.customer
join sakila.rental on sakila.rental.customer_id=sakila.customer.customer_id
where date(sakila.rental.rental_date)='2005-07-26';
 
-- distinct customers
select distinct(concat(sakila.customer.first_name,' ',sakila.customer.last_name)) as 'Full name' from sakila.customer
join sakila.rental on sakila.rental.customer_id=sakila.customer.customer_id
where date(sakila.rental.rental_date)='2005-07-26';

-- distinct last names of those customers who rented on 26th July 2005
select distinct(sakila.customer.last_name) from sakila.customer
join sakila.rental on sakila.rental.customer_id=sakila.customer.customer_id
where date(sakila.rental.rental_date)='2005-07-26';

-- distinct last names of all customers
select distinct(sakila.customer.last_name) from sakila.customer;

-- how many rentals we do on each day
select * from sakila.rental;

select date(sakila.rental.rental_date) as 'Rental Dates', count(*) as 'Rentals each day' from sakila.rental
	group by date(sakila.rental.rental_date);

-- Busiest rental day (day with most rentals)
select date(sakila.rental.rental_date) as 'Rental Dates', count(*) as 'Rentals each day' from sakila.rental
group by date(sakila.rental.rental_date)
order by count(*) desc
limit 1;

/*Question#7 : List all the sci-fi films in our catalogue
*/

select * from sakila.category;
select distinct name from sakila.category;  -- 16 genres of films
select count(*) from sakila.category
where sakila.category.name = 'Sci-Fi';

select * from sakila.film_category;
select * from sakila.category;  -- '14' is the category_id for 'sci-fi' films

select fc.category_id, fc.film_id from sakila.film_category fc
join sakila.category c on c.category_id=fc.category_id
where fc.category_id=c.category_id;

select c.category_id, c.name from sakila.category c
join sakila.film_category fc on fc.category_id=c.category_id
where fc.category_id=c.category_id;

select * from film_category;
select * from film_category
	where category_id = 14;  -- 61 sci-fi films. But we get film_id and not names. To get names, we'd have to go to fim table

select * from film;

select f.film_id, f.title from film f
join film_category fc on fc.film_id = f.film_id
where f.film_id = fc.film_id and f.film_id=14;

select * from category; -- this gets you the name 'sci-fi' correponding to the category_id 14.
select * from film_category;  -- this gets you the film_ids corresponding to the category_id 14.

select count(film_id) from film_category
where category_id = 14;  -- 61 sci-fi films

select film_id from film_category
where category_id = 14;  -- these are those 61 sci-fi films' film_ids

-- so far, we know that there are 61 sci-fi films, but we want their names and the names of the films is in the 'film' table
select * from film;  -- Notice that the film_id here can be used to join the film to film_cateogry table
-- #Approach#1

select f.film_id, f.title from film f
join film_category fc on fc.film_id = f.film_id
where f.film_id IN (select film_id from film_category
where category_id = 14); 

-- #Approach#2 : joins on 2 tables
select * from category;  -- from this we find that '14' is the sci-fi category's category_id
select * from film_category where category_id=14; -- from this we learn that there are 61 sci-fi films
select * from film;  -- from this we learn that we can use film_id column to join with film_category table to get the 'title' of the sci-fi films.

select f.film_id, f.title, c.name from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id=fc.category_id
where c.name = 'Sci-Fi';

/*Question#8 : Customers and how many movies they rented from us so far?
*/
show tables;

select * from customer -- get names of the customers from here
group by customer_id;

select distinct(customer_id) from customer;  -- there are only 599 customers
select count(customer_id) from customer;  -- 599

select * from payment;
select count(*) from payment;  -- 16044 records, proving that there are multiple rentals per customer.
select count(distinct(rental_id)) from payment;  -- 16044 records, proving that there multiple retal_ids per customer

select count(payment_id), customer_id from payment  -- returns number of rentals per customer (but doesn't have names, so join customer table on this to get names)
group by customer_id;

select concat(c.first_name,' ', c.last_name) as 'Full Names', count(p.payment_id) as 'Number of Rentals' from payment p
join customer c on c.customer_id = p.customer_id
group by p.customer_id;

-- sort by maximum number of rentals
select concat(c.first_name,' ', c.last_name) as 'Full Names', count(p.payment_id) as 'Number of Rentals' from payment p
join customer c on c.customer_id = p.customer_id
group by p.customer_id
order by count(p.payment_id) desc;

/* Question#9: Which film should we discontinue renting (least rented movie that is, <= 1)
*/

-- Approach#1

select * from inventory;  -- get inventory_id count from here : 4581. Note : It has film_id to join with film table to get the title of the film
select * from film;  -- get title from here
select * from rental;  -- this has inventory_id to join with inventory table

select r.inventory_id, count(*) as 'No. of rentals', f.title from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
group by r.inventory_id
having count(*) <=1
order by count(*);  -- films with least count of inventory_ids

-- Approach#2 : Using cte
select * from rental;

with cte_low_rentals as
	(select inventory_id, count(*) from rental
	group by inventory_id
	having count(*)<=1
	order by count(*))  -- this returns the inventory_ids of the least rented movies
select cte.inventory_id, f.title from cte_low_rentals cte
join inventory i on i.inventory_id = cte.inventory_id
join film f on f.film_id=i.film_id;

/* Question#10: Which films have not been returned yet!?
*/
select * from rental;
select count(*) from rental;  -- 16044 records
select count(return_date) from rental;  -- 15861 records

select 16044 - 15861 from dual;  -- 183 records

select * from inventory;  -- join this table on rental so we can join the film table to get the film title
select * from film;  -- film_id is available in this table as well as inventory table

with cte_r as
	(select * from rental
	where return_date IS NULL)
select cte_r.inventory_id, i.film_id, f.title from cte_r
join inventory i on i.inventory_id = cte_r.inventory_id
join film f on f.film_id = i.film_id
order by f.title;

/* Homework Q#1: How much money and rentals we make for Store 1 by day!?
*/
select * from payment;
select * from store;

select p.staff_id, sum(p.amount) as 'Total money made', count(p.rental_id) as 'Total rental count' from payment p
join store s on s.manager_staff_id = p.staff_id
group by p.staff_id
having p.staff_id = 1;

/* Homework Q#2: What are the top 3 earning days so far?
*/

select p.staff_id, p.amount as 'Total money made', p.rental_id as 'Total rental count', date(p.payment_date) from payment p
join store s on s.manager_staff_id = p.staff_id
having p.staff_id = 1
order by p.amount desc
limit 3;
