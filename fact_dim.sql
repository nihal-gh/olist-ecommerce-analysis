use olist_dw;
select p.product_id, p.product_category_name as old_name, pc.product_category_name_english as new_name
from staging_products p
join staging_product_category_translation pc on p.product_category_name=pc.product_category_name
limit 5;


update staging_products p
join staging_product_category_translation pc on p.product_category_name=pc.product_category_name
set p.product_category_name=pc.product_category_name_english
where product_id is not null;

select * from staging_products 
limit 10;

create table fact_products(
product_id varchar(30) not null primary key

);
select * from dim_products;

insert into dim_products(product_id, product_category_name, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
select product_id, product_category_name, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm
from staging_products;
select * from staging_sellers
limit 10;
create table dim_sellers(
seller_id varchar(50),
seller_zip_code_prefix varchar(10),
seller_city varchar(20),
seller_state varchar(5)
);
insert into dim_sellers(seller_id, seller_zip_code_prefix, seller_city, seller_state)
select seller_id, seller_zip_code_prefix, seller_city, seller_state
from staging_sellers;

select * from staging_sellers
limit 15;
select * from staging_order_payments;
select * from fact_order_payments;
/*order_id varchar(60) order_item_id int product_id varchar(60) seller_id varchar(50) shipping_limit_date timestamp price decimal(10,2) 
freight_value decimal(5,2)*/ 
insert into fact_order_items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
select order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value
from staging_order_items;


SELECT order_id, order_item_id
FROM staging_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

select * from staging_order_items;
show tables;
use olist_dw;
ALTER TABLE fact_order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id)
REFERENCES dim_products(product_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;
SHOW CREATE TABLE fact_order_items;


alter table dim_orders
add constraint fk_orders_customers
foreign key (customer_id)
references dim_customers(customer_id);

alter table fact_order_items 
add constraint fk_items_products
foreign key(product_id)
references dim_products(product_id);


select count(order_id)
from fact_order_payments
group by order_id
having count(order_id)>1;


alter table fact_order_payments 
add constraint fk_order_orders
foreign key(product_id)
references dim_products(product_id);

ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
SELECT user, host FROM mysql.user;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES;






show tables;
SELECT * FROM dim_orders LIMIT 5;
SELECT * FROM dim_products LIMIT 5;
SELECT * FROM dim_sellers LIMIT 5;
SELECT * FROM dim_customers LIMIT 5;
SELECT * FROM fact_order_items LIMIT 5;
SELECT * FROM fact_order_payments LIMIT 5;
select * from fact_order_reviews limit 5
















