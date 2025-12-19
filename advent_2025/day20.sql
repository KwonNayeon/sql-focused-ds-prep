-- 온라인 구매만 카운트해야 함
with cte as (
  select
    *,
    extract(year from purchased_at) as year
  from transactions
  where is_online_order = 1
)
select
  year,
  sum(case when shipping_method = 'Standard' then 1 else 0 end) 
    + sum(case when is_returned = 1 then 1 else 0 end) as standard,
  sum(case when shipping_method = 'Express' then 1 else 0 end) as express,
  sum(case when shipping_method = 'Overnight' then 1 else 0 end) as overnight
from cte
group by year
order by year
;
