with cte as (
  select
    case when total_bill >= 25 then 2
        when total_bill < 25 and total_bill >= 15 then 1
        else 0 end as stamp
  from tips
)
select
  stamp,
  count(stamp) as count_bill
from cte
group by stamp
;