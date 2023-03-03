create database zomato;
use zomato;
--- Q.1) select a particular database
use zomato;

--- Q.2) count number of rows
select count(*) from users;

--- Q.3) return n random record
select * from users order by rand() limit 5;

--- Q.4) Find null values
select count(*) from orders where restaurant_rating is not null;

--- To replace null values with zero
--- update orders set restaurant_rating = 0 where restaurant_rating is null;

--- Q.5) Find number of orders placed by each customer
select name,count(order_id) as 'num_orders' from users u 
inner join orders o on u.user_id=o.user_id group by name; 

--- Q.6) Find restaurant with most number of menu item
select r_name,count(*) as 'number_of_menu_item' from restaurants r
inner join menu m on r.r_id=m.r_id group by m.r_id; 

--- Q.7) Find number of votes and average rating for all the restaurant
select r_name,count(*) as 'num_votes',round(avg(restaurant_rating),2) as 'avg_rating' from restaurants r
inner join orders o on r.r_id=o.r_id where restaurant_rating is not null
group by o.r_id;

--- Q.8) Find the food that is being sold at most number of restaurant
select f_name,count(*) from menu t1 inner join food t2 on
t1.f_id=t2.f_id group by t1.f_id order by count(*) desc limit 1;

--- Q.9) Find restaurant with max revenue in a given month
--- select DATE(date) from orders;
--- select monthname(date(date)),date from orders;
select r_name,sum(amount) as 'Revenue' from orders t1 join restaurants t2 
on t1.r_id=t2.r_id
where monthname(date(date))='May'
group by t1.r_id
order by revenue desc limit 1;

use zomato;

select monthname(date(date)),sum(amount) as 'Revenue' from orders t1 join restaurants t2 
on t1.r_id=t2.r_id
where r_name='kfc'
group by monthname(date(date))
order by month(date(date));

--- Q.10) Find restaurants with sales> x
select r_name,sum(amount) as 'revenue' from orders t1 join restaurants t2 
on t1.r_id=t2.r_id
group by t1.r_id
having revenue > 1500;

--- Q.11) Find customers who have never ordered

select user_id from users
except
select user_id,name from orders t1 join users t2
on t1.user_id= t2.user_id;

--- Q.12) Show order details of particular customer in given date range

select t1.order_id,f_name,date from orders t1
join order_details t2 
on t1.order_id=t2.order_id
join food t3
on t2.f_id=t3.f_id
where user_id=1 and date between '2022-05-15'
and '2022-06-15';


--- Q.13) Customer favorite food
select t1.user_id,t3.f_id,count(*) from users t1 
join orders t2 on t1.user_id=t2.user_id
join order_details t3 on t2.order_id=t3.order_id
group by t1.user_id,t3.f_id;

--- Q.14) find most costly restaurant(Avg price/dish)

Select  r_name,(sum(price)/count(*)) as 'avg_price' from menu t1
join restaurants t2
on t1.r_id=t2.r_id
group by t1.r_id 
order by avg_price asc limit 1;


--- Q.15) find delievery partner compensation using the formula

select partner_name,(count(*)*100 + avg(delivery_rating)*1000) as 'Salary'
from orders t1
join delivery_partner t2
on t1.partner_id=t2.partner_id
group by t1.partner_id
order by salary desc;


--- Q.16) find revenue per month for a restaurant
select r_name,sum(amount) as 'revenue' from orders t1 join restaurants t2 
on t1.r_id=t2.r_id
group by t1.r_id;


--- Q.17) find all the veg restaurant
select r_name from menu t1
join food t2 on t1.f_id=t2.f_id
join restaurants t3 on t1.r_id=t3.r_id
group by t1.r_id
having min(type) ='veg' and max(type) ='veg';

--- Q.18) find min and max order value for each customer
select name,min(amount),max(amount) from orders t1 
join users t2 on t1.user_id=t2.user_id
group by t1.user_id;
