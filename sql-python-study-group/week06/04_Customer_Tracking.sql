/*
-- INTERVAL (시간 간격) → 숫자(초)
EXTRACT(EPOCH FROM INTERVAL '1 hour 30 minutes')
-- 결과: 5400 초

-- TIMESTAMP 차이 → 숫자(초)
EXTRACT(EPOCH FROM ('10:00' - '08:00'))
-- 결과: 7200 초
*/

with session as (
    select
        cust_id,
        timestamp as start_time,
        lead(timestamp) over (partition by cust_id order by timestamp) as end_time,
        state,
        lead(state) over (partition by cust_id order by timestamp) as next_state
    from cust_tracking
)
select
    cust_id,
    sum(extract(epoch from (end_time - start_time)) / 3600) as total_hours
from session
where state = 1 and next_state = 0
group by cust_id
;

-- Review Notes:
-- 2025-12-12: 복습하기
