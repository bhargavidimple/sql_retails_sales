create database sql_project1;
use sql_project1;

create table retail_sales(
	transactions_id	int primary key, 
    sale_date date,
    sale_time time,
	customer_id	int,
    gender	varchar(20),
    age	int ,
    category varchar(30),
	quantiy	int, 
    price_per_unit float,
    cogs float,
    total_sale float
);

select *from retail_sales;
-- data cleaning in the  given table called retail_sales
select *from retail_sales where sale_date is null or
sale_time is null or customer_id is null or gender is null or age is null or quantiy is 
null or price_per_unit  is null or cogs is null or total_sale is null ;

-- how many sales  
select distinct count(transactions_id) from retail_sales;
 
-- select the unique customer 
select count(distinct customer_id) from retail_sales;

-- unique categories
select distinct category from retail_sales;

-- data analysis  and business key problems 

-- write a sql query  to retrive the all coumns for sales made on 2022-11-06
select *from retail_sales where sale_date="2022-11-06";

-- write a sql query to retrive the category of clothing where the quantity sold is greater than 10 and also 
-- in the month of nov 2022
select *from retail_sales where category='Clothing' and quantiy >3 
and date_format(sale_date,"%b %Y")="Nov 2022";
 -- or we can write as 
 use sql_project1;
select *from retail_sales where category='Clothing' and quantiy >3 and  
sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- write a query  to select the total sales for each category
select category,count(*) as totalsales from retail_sales group by category;

-- write a query to   find the average age of the customers  who purchased the items from the 
-- beauty category
select round(avg(age),2) from retail_sales where category='Beauty';

-- write a sql  query to  find the all transactions where the total sale is greater than 1000;
select count(transactions_id) from retail_sales where total_sale >1000;
select transactions_id from retail_sales where total_sale >1000;

-- write a query to retrive the no of transactions made by each gender in each category
select category,gender,count(*) as no_of_transaction from retail_sales  group by category,gender;

-- write a sql  query for calculation of avg sale for  each month find the best selling month in each  year;
with r as (
select year(s.sale_date)as y,month(s.sale_date) as m ,avg(s.total_sale) as a,
rank() over (partition by year(s.sale_date)order by avg(s.total_sale) desc )as highest
 from retail_sales s group by y,m)
 select y,m from r where r.highest=1;

-- write a sql query to select the top 5 customers based on the highest total_sales
with ranks as(
select customer_id ,sum(total_sale) as total,rank() over(order by 
sum(total_sale) desc)as highestranks from retail_sales group by customer_id)
select customer_id,total from ranks where highestranks<=5;
select *from retail_sales;
-- write a sql query to find the unique customers who purchased items from each category
select count(distinct customer_id) as customers ,category from retail_sales group by category ;

-- write a query create each shift anf no of orders (eg morning <=12  afternoon between 12 and 7)
with shifts as(select *,
case 
 when hour(sale_time)<=12 then "morning"
 when hour(sale_time)  between 12 and 17 then "afternoon"
 else "evening" end as shift
 from retail_sales) 
 select shift ,count(*) as total_orders from shifts group by shift;
 
select *from retail_sales;

-- end of the project 


