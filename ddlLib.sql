
-- create students table
create table books(
    book_id int unsigned auto_increment primary key,
    title varchar(200) not null
) engine = innodb;

-- insert into tables
insert into books (title) values ("Lord of the rings");
-- insert multiple
insert into books (title) values 
    ("Pride and prejudice"),
    ("little prince")
    ;

-- create table for authors
create table authors(
    author_id int unsigned auto_increment primary key,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    date_of_birth date
) engine= innodb;

-- create data
insert into authors (first_name, last_name, date_of_birth) values 
    ("Tim", "John", "1989-02-13"),
    ("Rock", "Feller", "1989-03-13");

-- table for publisher
create table publishers(
    publisher_id smallint unsigned auto_increment primary key,
    name varchar(100) not null,
    address varchar(255) not null,
    contact_email varchar(50) not null
) engine=innodb;

-- publisher data
insert into publishers (name, address, contact_email) values
    ("Tianxia", "Hong Kong Tong Luo Wan Stree", "Tianxia@gmail.com"),
    ("Penguin Random House","Changi South Street 3, #08-01 No. 9, Singapore 486361","consumerservices@penguinrandomhouse.com");


-- create table for memebers
create table members(
    member_id MEDIUMINT unsigned auto_increment primary key,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    address varchar(255) not null 
)engine =innodb;

-- create data for members
insert into members (first_name, last_name, address) values
    ("Phua", "Chu kang", "CCK Blk 223"),
    ("Auntie", "Lian", "Yixun Ring Road Blk 213");

-- create reservations table
create table reservations(
    reservation_id int unsigned auto_increment primary key
) engine=innodb;

-- create a column for fk
alter table reservations add column member_id MEDIUMINT unsigned; 