-- 사용자 ID가 10으로 나누어 떨어지는 사용자를 A 버킷으로, 나누어 떨어지지 않는 사용자를 B 버킷으로 나누는 것 (처음에 거래 ID를 사용함)
-- 사용자 ID별 total revenue를 구한 후 평균 구하기
with cte as (
  select
    customer_id,
    case when customer_id % 10 = 0 then 'A' else 'B' end as bucket,
    count(transaction_id) as order_count,
    sum(total_price) as total_revenue
  from transactions
  where is_returned = 0
  group by customer_id, bucket
)
select
  bucket,
  count(customer_id) as user_count,
  round(avg(order_count),2) as avg_orders,
  round(avg(total_revenue),2) as avg_revenue
from cte 
group by bucket
order by bucket
;
