select
    first_name,
    last_name,
    city,
    order_details
from customers c
left join orders o on c.id = o.cust_id
order by first_name, order_details asc

-- Review Notes:
-- 2025-11-06: 비교적 쉬웠음
