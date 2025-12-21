-- rows between 1 preceding and current row: 전날 + 당일 = 연속된 이틀간의 합
with cte as (
  select
    date(purchased_at) as order_date,
    dayname(purchased_at) as weekday,
    count(*) as num_orders_today
  from transactions
  where is_online_order = 1
  and extract(year from purchased_at) = 2023
  group by date(purchased_at), dayname(purchased_at)
)
select
  order_date,
  weekday,
  num_orders_today,
  sum(num_orders_today) over (order by order_date rows between 1 preceding and current row) as num_orders_from_yesterday
from cte
order by order_date
;
