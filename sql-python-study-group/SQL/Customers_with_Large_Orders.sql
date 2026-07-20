select
    distinct c.customer_id,
    c.customer_name
from online_store_customers c
join online_store_orders o
on c.customer_id = o.customer_id
where o.amount > 100
;

-- 다른 풀이
select
    c.customer_id,
    c.customer_name
from online_store_customers c
where exists (
    select 1
    from online_store_orders o
    where c.customer_id = o.customer_id
    and o.amount > 100
)
;
