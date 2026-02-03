-- Find the percentage of shipable orders
select
    (count(case when c.address is not null then 1 end) * 1.0 / count(*) * 1.0)*100 as shipable_orders
from orders o
join customers c
on o.cust_id = c.id
;
