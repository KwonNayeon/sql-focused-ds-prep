-- distinct로 중복을 제거해야 함
select
  distinct customer_id,
  case when customer_id % 10 = 0 then 'A' else 'B' end as bucket
from transactions
where is_online_order = 1
order by customer_id
;
