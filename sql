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
order by results desc limit 5 ; 

-- Join the necessary tables to find the total quantity of each pizza category ordered
select pt.category , sum(od.quantity) as Pizza_type_quantity from pizza_types as pt
join pizzas as p on p.pizza_type_id = pt.pizza_type_id
join order_details as od on od.pizza_id = p.pizza_id
group by pt.category 
order by Pizza_type_quantity  desc ;

-- Determine the distribution of orders by hour of the day.
select hour(time) as order_time , count(order_id) as ttl_orders from orders
group by order_time
order by ttl_orders desc ;

-- Determine the top 3 most ordered pizza types based on revenue.
select pt.name as most_ordered_pizza , sum(od.quantity * p.price) as total_revenue
from pizzas as p 
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
join order_details as od on p.pizza_id = od.pizza_id
group by  pt.name 
order by total_revenue 
limit 3;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select pt.name as most_orderd, pt.category,sum(od.quantity * p.price)as revenue from pizzas as p
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
join order_details as od on p.pizza_id = od.pizza_id
group by pt.category,pt.name
order by revenue desc 
limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.name AS pizza_type,
    pt.category,
    SUM(od.quantity * p.price) AS pizza_revenue,
    ROUND((SUM(od.quantity * p.price) / (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id)) * 100, 2) AS percentage_contribution
FROM 
    pizzas p
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 
    pt.name, pt.category
ORDER BY 
    percentage_contribution DESC;


 --  Analyze the cumulative revenue generated over time.
SELECT 
    o.date,
    SUM(od.quantity * p.price) AS daily_revenue,
    SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date) AS cumulative_revenue
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    o.date
ORDER BY 
    o.date;
