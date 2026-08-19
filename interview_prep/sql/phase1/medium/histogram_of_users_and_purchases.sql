with cte as (
  SELECT
    transaction_date,
    user_id,
    count(product_id) as purchase_count,
    row_number() over (partition by user_id order by transaction_date desc) as rn
  FROM user_transactions
  group by user_id, transaction_date
)
select
  transaction_date,
  user_id,
  purchase_count
from cte
where rn=1
order by transaction_date asc
;

-- Review Notes:
-- 2026-08-19: 문제에 명시되지 않은 조건: 고객이 가장 최근 날짜에 구입한 물품의 수만 세야함
