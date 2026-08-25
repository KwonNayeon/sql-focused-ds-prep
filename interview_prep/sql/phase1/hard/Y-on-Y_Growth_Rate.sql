with cte1 as (
  SELECT
    extract(year from transaction_date) as year,
    product_id,
    sum(spend) as curr_year_spend
  FROM user_transactions
  group by extract(year from transaction_date), product_id
),
cte2 as (
  select
    *,
    lag(curr_year_spend) over (partition by product_id order by year) as prev_year_spend
  from cte1
)
select
  *,
  round((curr_year_spend-prev_year_spend)*1.0/prev_year_spend*100,2)
from cte2
;

-- Review Notes:
-- 2026-08-25: 다른 풀이 복습하기
