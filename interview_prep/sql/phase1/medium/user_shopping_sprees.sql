with cte as (
  SELECT
    user_id,
    lag(transaction_date, 1) over (partition by user_id order by transaction_date) as prev_day,
    transaction_date,
    lead(transaction_date, 1) over (partition by user_id order by transaction_date) as next_day
  FROM transactions
)
select user_id
from cte
where prev_day = transaction_date - interval '1 day'
and next_day = transaction_date + interval '1 day'
;

-- Review Notes:
-- 2026-08-18: lag, lead는 날짜상으로 정확히 하루 차이가 난다는 조건을 보장하지 않음.  그래서 연속성을 체크할 때는 where절 조건이 필수, 복습하기
