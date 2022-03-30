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


-- aggregate functions

select AVG(creditLimit) FROM customers;
select MAX(creditLimit) FROM customers;

select min(creditLimit) from customers
where creditLimit>0

-- select filter dates
select * from payments where paymentDate > "2004-04-01"

-- you can take out year, month and day
select year(paymentDate), Month(paymentDate), day(paymentDate), amount from payments;

-- find total amount for the month of june across all years
select sum(amount) from payments where month(paymentDate)=6;

-- group by happen before select
-- columns are always selected last
-- where and group by operates first
-- you can only select what have grouped,
select officeCode, count(*) from employees group by officeCode



-- step 4 - select columns (-- must select same columns as group by columns)
select products.productCode, productName, count(*) 
-- step 1 - from join
from orderdetails
join products on products.productCode = orderdetails.productCOde
-- step 2 - where to filter rows
where productLine = "Classic Cars"
-- step 3 - group by 
group by productCode, productName

-- step 5 - having

having count(*)>=28

-- step 6, 7 -- order and limit
order by count(*) desc
limit 10;

-- SUB QUERIES
 -- ex:1 find all customers whose credit limit above the average
 select * from customers where creditLimit > (select avg(creditLimit) from customers);

-- filter product code is not in the distinct product code
select * from products 
where productCode not in (select distinct(productCode) from orderdetails)


 -- ex:3 use a subquery to find all customers with no sales rep employee number
 select * from customers where customerNumber NOT IN (
select customerNumber from customers where salesRepEmployeeNumber IS NOT NULL);


-- ex:4 
SELECT employees.employeeNumber, employees.firstName, employees.lastName, SUM(amount) FROM employees JOIN customers
   ON employees.employeeNumber = customers.salesRepEmployeeNumber
 JOIN payments
   ON customers.customerNumber = payments.customerNumber
 GROUP BY employees.employeeNumber, employees.firstName, employees.lastName
 HAVING sum(amount) > (select sum(amount) * 0.1 from payments);

 -- BONUS: find the best selling product for each year and month:
 select year(orderDate) as orderYear, month(orderDate) as orderMonth, productCode, sum(quantityOrdered) from orderdetails 
  join orders on orderdetails.orderNumber = orders.orderNumber
group by productCode, month(orderDate), year(orderDate)
having productCode = ( select productCode from orderdetails 
  join orders on orderdetails.orderNumber = orders.orderNumber
  where year(orderDate)=orderYear and month(orderDate)=orderMonth
  group by productCode
  order by sum(quantityOrdered) desc
  limit 1
 )
 order by year(orderDate), month(orderDate);

