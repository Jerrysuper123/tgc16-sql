-- create new database
-- database is case insensitive
create database swimming_school

-- check current selected database
select DATABASE();

-- to switch database
use swimming_school;

-- create table
-- <name of column> <data type> <options>
create table parents(
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null,
    -- you can put default " ", instead of not null
    last_name varchar(200) default ''
) engine = innodb;
-- `engine = innodb` is for FK to work

-- show all tables
show tables;

-- insert
-- insert into table, which (column 1, column 2), values (value 1, value 2)
insert into parents (first_name, last_name) values ("Ah Kow", "tan");

-- show all rows from table
select * from parents;

-- insert multiple rows
insert into parents (first_name, last_name) values
    ("Chua Kang", "Phua"), 
    ("Ah Teck", "Tan"),
    ("See Mei", "Liang");

-- create the student table (sql is case insensitive)
CREATE TABLE students(
    student_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name varchar(45) not null,
    swimming_level varchar(45),
    date_of_birth date
) engine = innodb;

-- add in FK
-- step 1: create column for the fk
alter table students add column parent_id int unsigned;
-- step 2: set up the foreign key
alter table students add constraint fk_students_parents
    foreign key (parent_id) references parents(parent_id);

-- describe table
describe parents;

-- insert in some students
insert into students (name, swimming_level, date_of_birth, parent_id)
 values ('Xiao Kow', 'beginner', '2010-09-10', 4);

-- update must come with WHERE
update students set swimming_level="intermediate" WHERE student_id=2;

-- delete 
delete from students where student_id=1;

-- rename columns
alter table students rename column name to first_name;

-- rename table
rename table students to swimming_students;

-- create reservations table
create table reservations(
    reservation_id int unsigned auto_increment primary key;
)