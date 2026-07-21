with purchases as (
    select
        user_id,
        extract(day from created_at) as day
    from amazon_transactions
),
with_lag as (
    select
        user_id,
        day,
        lag(day) over (partition by user_id order by day) as previous_day
    from purchases
)
select
    distinct user_id
from with_lag
where (day - previous_day) between 1 and 7      -- same day purchases는 제외
;

-- 다른 풀이
with cte as (
    select
        *,
        lag(created_at) over (partition by user_id order by created_at) as previous_day
    from amazon_transactions
)
select
    distinct user_id
from cte
where (created_at-previous_day) < 8
and created_at!=previous_day
;

