
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

-- add in constraint
alter table reservations add constraint FK_reservation_member
    foreign key(member_id) references members(member_id);

-- insert into members 
insert into reservations (member_id) values (1);

create table editions(
    edition_id int unsigned auto_increment primary key,
    ISBN varchar(13) not null
) engine=innodb;

alter table editions add column publisher_id smallint unsigned, add column book_id int unsigned;

alter table editions add constraint FK_editions_publishers
    foreign key(publisher_id) references publishers(publisher_id);

alter table editions add constraint FK_editions_books
    foreign key(book_id) references books(book_id);

insert into editions (ISBN, publisher_id, book_id) values 
    ("9783161484100", 1, 1),
    ("9783161422200", 2, 2);

create table copies(
    copy_id int unsigned auto_increment primary key,
    quality int unsigned not null
) engine=innodb;

alter table copies add column book_id int unsigned, add column reservation_id int unsigned;

alter table copies add constraint FK_copies_books
    foreign key(book_id) references books(book_id);

alter table copies add constraint FK_copies_reservations
    foreign key(reservation_id) references reservations(reservation_id);

insert into copies (quality, book_id, reservation_id) values 
    (1, 1, 1);

create table loans(
    loan_id int unsigned auto_increment primary key,
    date_due date not null,
    date_returned date not null
) engine=innodb;

alter table loans add column copy_id int unsigned, add column member_id MEDIUMINT unsigned;

alter table loans add constraint FK_loans_copies
    foreign key(copy_id) references copies(copy_id);

alter table loans add constraint FK_loans_members
    foreign key(member_id) references members(member_id);

insert into loans (date_due, date_returned, copy_id, member_id) values ("2022-02-03", "2022-03-02", 3, 1);

create table writingCredits(
    writingCredit_id int unsigned auto_increment primary key
) engine=innodb;

alter table writingCredits add column author_id int unsigned, add column book_id MEDIUMINT unsigned;

alter table loans add constraint FK_loans_copies
    foreign key(copy_id) references copies(copy_id);

alter table loans add constraint FK_loans_members
    foreign key(member_id) references members(member_id);