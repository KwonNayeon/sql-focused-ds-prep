-- 첫 번째 풀이
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

-- 개선된 풀이
with yearly_spend_cte as (
  SELECT
    extract(year from transaction_date) as year,
    product_id,
    spend as curr_year_spend,
    lag(spend) over (partition by product_id order by product_id, extract(year from transaction_date)) as prev_year_spend
  FROM user_transactions
)
select
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  round((curr_year_spend-prev_year_spend)*1.0/prev_year_spend*100,2) as yoy_rate
from yearly_spend_cte
;

-- Review Notes:
-- 2026-08-25: 다른 풀이 복습하기
-- 2026-08-26: 푸는 방법 개선
