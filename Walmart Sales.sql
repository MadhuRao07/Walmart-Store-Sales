create Database Walmart;
use Walmart;
select * from walmart;
drop table sales;
create table sales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_pirce decimal(10,2) not null,
Quantity int not null,
VAT float(6,4) not null,
total decimal(12,4) not null,
date datetime not null,
time time not null,
payment_method varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income decimal(12,4) not null,
rating float (2,1));

select * from sales;




 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------- Feature Engineering---------------------------------------------------------------------------------
 
 -- time_of_date 
 
 select time, 
 (case when time between '00:00:00' and '12:00:00' then 'Morning'
  when time between '12:01:00' and '16:00:00' then 'Afternoon'
 else 'Evening'
 end ) as time_of_date from sales;
 
 alter table sales add column time_of_date varchar(20) ;
 update sales set time_of_date = (case when time between '00:00:00' and '12:00:00' then 'Morning'
  when time between '12:01:00' and '16:00:00' then 'Afternoon'
 else 'Evening'
 end ) ;
 set sql_safe_updates =0;
 
 
 -- day_name 
 
 select  date, dayname(date) from sales;
 
 alter table sales add column day_name varchar(20) ;
 update  sales set day_name = dayname(date);
	
-- Month_name

select date,monthname(date) from sales;
alter table sales add column month_name varchar(20) ;
update  sales set month_name = monthname(date);


----------------------------------------------------------------- Generic Questions---------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- How many uniques citites does the data have ?
select distinct(city) from sales;       

-- In which city is each branch ?
select distinct(branch)from sales;

select distinct branch,city from sales;




----------------------------------------------------------------- Product -------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1. How many unique product lines does the data have? 
select  count(distinct product_line) from sales;

-- Q2. What is the most common payment maythod ?
select payment_method , count(payment_method) as cnt from sales group by payment_method  order by cnt desc;

-- Q3. What is the most selling product line ?
select product_line , count(product_line) as cnt from sales group by product_line order by cnt desc;


-- Q4. What is the total revenue by month ?
select month_name, sum(total) as total_revenue from sales group by month_name order by total_revenue desc;

-- Q5 . What month had the largest COGS ?
select month_name , sum(cogs) as Largest_cogs from sales group by month_name order by largest_cogs desc;

-- Q6. What product line had the largest revenue ?
select product_line, sum(total) as largest_revenue from sales group by 1 order by largest_revenue desc;

-- Q7. What is the city with the largest revenue ?
select city,branch, sum(total) as largest_revenue from sales group by 1,2 order by largest_revenue desc;

-- Q8. What product line had the largest VAT? 
select product_line ,max(vat) as Largest_vat from sales group by 1 order by largest_vat desc;

-- Q9. which branch sold more product than avgerage product sold?
select * from sales;
select branch , sum(quantity) as qty from sales group by 1 having sum(quantity)> (select avg(quantity) from sales);

-- Q 10. What is the most commom product line by  gender?
select gender,product_line,count(gender) as total_cnt from sales group by 1,2 order by total_cnt desc;

-- What is the average rating of each product ?
select product_line , avg(rating)as average_rating from sales group by 1 ;
