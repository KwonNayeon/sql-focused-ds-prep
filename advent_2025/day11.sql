-- 매출액 = total_bill
with total_sales as (
  select
    total_bill,
    day
  from tips
)
select
  case when day in ('Sat', 'Sun') then 'weekend' else 'weekday' end as week,
  sum(total_bill) as sales
from total_sales
group by week
order by sales desc
