-- Customer Revenue In March
select
    cust_id,
    sum(total_order_cost) as revenue
from orders
where extract(month from order_date) = 3
group by cust_id
order by sum(total_order_cost) desc
;

select
    cust_id,
    sum(total_order_cost) as total_revenue
from orders
where order_date >= '2019-03-01' and order_date <= '2019-03-31' and order_date is not null
group by cust_id
order by total_revenue desc

-- Review Notes:
-- 2026-02-08: 복습 완료
