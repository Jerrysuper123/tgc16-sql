
# Logging in via the terminal

For Gitpod, PC
```
mysql -u root
```

For MacOS
```
mysql -u root -p
```

# SQL Commands
1. DDL - Data Definition Language
2. Data Query language

# DDL

## Create a database
```
create database swimming_school;
```

## show database
```
show databases;
```

## check databases
select DATABASE();

## Switch database
```
use swimming_school;
```

## Create tables


## sakila 

```
mysql -u root < sakila-schema.sql
mysql -u root < sakila-data.sql
```

## dependancies
```
yarn add express
yarn add hbs
yarn add wax-on
yarn add handlebars-helpers
yarn add mysql2

```
* mysql2 - someone add more features to first versions, it allows nodejs application to send sql commands to mysql
* the difference between sql1 and sql2 is that latter supports promises and await/async

use start.sh to automate commonly used task
```
what code to use
```