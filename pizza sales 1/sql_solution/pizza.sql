select sum(price) as total_revenue_all,  count(distinct order_id) as num_of_orders, count( order_id) as num_of_pieces , round(avg(price),2) as average_price_per_pizza 
from sales;

select month(date) as month, sum(price) as total_revenue
from sales
group by month(date);


select dayname(date) as day, sum(price) as total_revenue
from sales
group by dayofweek(date), dayname(date)
order by sum(price) desc;

select type, sum(price) as total_revenue
from sales
group by type
order by sum(price) desc;

select size, sum(price) as total_revenue_by_size
from sales
group by size
order by sum(price) desc;

select name, sum(price) as sum_revenue, sum(order_id) as num_of_pizzas_sold
from sales
group by name
order by sum(price) desc
limit 10;

WITH monthly_sales AS (
    SELECT 
        MONTH(date) AS month_num,
        DATE_FORMAT(date, '%M') AS month_name,
        SUM(price) AS monthly_revenue
    FROM sales
    GROUP BY MONTH(date), DATE_FORMAT(date, '%M')
    ORDER BY month_num
)
SELECT 
    month_name,
    monthly_revenue,
    LAG(monthly_revenue, 1) OVER (ORDER BY month_num) AS prev_month_revenue,
    monthly_revenue - LAG(monthly_revenue, 1) OVER (ORDER BY month_num) AS difference,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue, 1) OVER (ORDER BY month_num)) 
        / LAG(monthly_revenue, 1) OVER (ORDER BY month_num) * 100, 
        2
    ) AS percent_change
FROM monthly_sales;


