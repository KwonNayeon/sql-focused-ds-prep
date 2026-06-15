select
    c.id as c_id,
    c.first_name,
    sum(o.total_order_cost) as total
from customers c
right join orders o
on c.id = o.cust_id
group by c_id, first_name
order by first_name
