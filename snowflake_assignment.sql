use database test;

------to create table with order_date as primary key
create or replace table sales_data_final(
order_id	varchar(20),
order_date	date not null primary key ,
ship_date	date,
ship_mode	varchar(20),
customer_name	varchar(50),
segment	varchar(30),
state	varchar(50),
country	varchar(50),
market	varchar(30),
region	varchar(30),
product_id	varchar(30),
category	varchar(50),
sub_category	varchar(50),
product_name	varchar(200),
sales	number,
quantity	decimal(10,2),
discount	decimal(10,3),
profit	decimal(10,3),
shipping_cost	decimal(10,3),
order_priority	varchar(10),
year  varchar(5));


select * from sales_data_final;

-----to change primary key to order_id column
alter table sales_data_final drop primary key;  --as there can't be 2 primary keys we should drop 1 primary key to make other
alter table sales_data_final add primary key(order_id);

-----to check data type of all columns
describe table sales_data_final; --order_date and ship_date is in date datatype

--Create a new column called order_extract and extract the number after the last‘–‘from Order ID column.
select *, substring(order_id,9) as order_extract from sales_data_final;
select order_id, substring(order_id,9) as order_extract  from sales_data_final;

-----Create a new column called Discount Flag and categorize it based on discount.Use ‘Yes’ if the discount is greater than zero else ‘No’.
select * from sales_data_final;


select discount, 
    case
        when discount = 0 then 'yes'
        else 'no'
    end as discount_flag 
from sales_data_final;

-------Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.

select datediff(day , order_date ,ship_date) as process_days from sales_data_final ;

/*Create a new column called Rating and then based on the Process dates giverating like given below.
a. If process days less than or equal to 3days then rating should be 5
b. If process days are greater than 3 and less than or equal to 6 then rating
should be 4
c. If process days are greater than 6 and less than or equal to 10 then rating
should be 3
d. If process days are greater than 10 then the rating should be 2.*/
create or replace view sales_data_process_days as
select ORDER_ID,ORDER_DATE,SHIP_DATE, 
datediff(day , order_date ,ship_date) as process_days
from sales_data_final ;

select * from  sales_data_process_days;

select process_days,
    case
        when process_days <= 3 then 5
        when process_days > 3 and process_days <= 6 then 4
        when process_days > 6 and process_days <= 10 then 3
        else 2
    end as rating
from sales_data_process_days;




















