-- select all columns
select * from customers where customerNumber=103;

-- display certain columns
select firstName, lastName  from employees;

-- remove duplicates
select distinct(jobTitle) from employees;

-- rename columns as you select them
select firstName as "First Name", 
lastName as "Last Name",
email as "Email" from employees;

-- use where to filter rows
-- select is to select which columns, where is for which rows to show
select * from employees where officeCode=1;

-- below technique only works for string
-- if you use like, you can use wildcard character %
select * from employees where jobTitle LIKE "sales%";

-- Find employees as long as its job titles include sales
select * from employees where jobTitle LIKE "%sales%";

-- multi and or chaining
SELECT * FROM customers where state="NV" and country="USA" and creditLimit>5000;

-- select columns from table 1 joins table 2 where officeCode is the same
-- join tables happen first, select happens after joining
select * from employees join offices
ON employees.officeCode = offices.officeCode;

-- there are 2 officeCode in the joined table
-- put in employees.officeCode to let sql which column to choose from 
select firstName, employees.OfficeCode from employees join offices
ON employees.officeCode = offices.officeCode;

-- 1) join first step
-- 2) where to select rows
-- 3) select columns as last step
select firstName, employees.OfficeCode from employees join offices
ON employees.officeCode = offices.officeCode
WHERE country = "USA"

-- orderby to sort alphabet in ascending order
-- order of execution: join, filter rows, order by and then select
-- inner join
select firstName, employees.OfficeCode 
    from employees join offices ON employees.officeCode = offices.officeCode
    WHERE country = "USA"
    ORDER BY firstName;

-- the above is inner join, there also left and right join (keep the same rows as original left and right table)
-- inner join only produce 23 rows where there is ONLY a match
select count(*) from employees join offices
ON employees.officeCode = offices.officeCode

-- left join product the same number of rows of left table customers
-- comprehensive report of customers is produced
select count(*) from customers LEFT join employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber