# SQL Analysis Project

## Queries Overview

  -- Retrieve the total number of orders placed
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales. 
select sum(p.price*od.quantity) as ttl_revenue 
from pizzas as p
join order_details as od 
on p.pizza_id = od.pizza_id;

-- Identify the highest-priced pizza.
select max(p.price), pt.name as highest_priced 
from pizzas as p join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id;

select p.price , pt.name as highest_priced 
from pizzas as p join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id
order by p.price desc limit 1;

-- Identify the most common pizza size ordered.
select p.size,(count(od.order_details_id)) as most_common_size from pizzas as p
join order_details as od on p.pizza_id = od.pizza_id
group by size 
order by most_common_size desc;

-- List the top 5 most ordered pizza types along with their quantities.
select pt.name, sum(od.quantity) as results
from pizzas as p 
join order_details as od on p.pizza_id = od.pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
group by pt.name 
order by results desc; 
