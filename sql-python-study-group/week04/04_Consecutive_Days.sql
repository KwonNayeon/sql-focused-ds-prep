-- Consecutive Days

with consecutive as (
    select
        user_id,
        record_date,
        lag(record_date) over (partition by user_id order by record_date) as previous_day,
        lead(record_date) over (partition by user_id order by record_date) as next_day
    from sf_events
)
select
-- distinct 추가 (한 유저가 여러 번 조건을 만족할 수 있으므로)
    distinct user_id
from consecutive
where (record_date - previous_day) = 1 and (next_day - record_date) = 1

-- Review Notes:
-- 2025-11-29: lag, lead 활용하기
