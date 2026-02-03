CREATE DATABASE if not exists olist_dw  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
;

use olist_dw;
create table if not exists staging_customers(
	customer_id varchar(50)not null,
    customer_unique_id varchar(50),
    customer_zip_code_prefix varchar(10),
    customer_city varchar(50),
    customer_state varchar(10)
    );


alter table staging_customers 
modify column customer_id varchar(50) not null;
show tables;
use olist_dw;
select * from staging_customers;
SELECT DATABASE();
insert into staging_customers(customer_zip_code_prefix)values ('012234');
select * from staging_customers;

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE "C:/Datasets/olist dataset/olist_customers_dataset.csv"
INTO TABLE staging_customers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
