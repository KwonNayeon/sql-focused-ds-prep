/*
 - (end_time - start_time) → 두 시간의 차이를 interval(시간 간격) 타입으로 계산
 - extract(epoch from ...) → 그 interval을 총 초(seconds) 단위로 변환
 - / 3600 → 초를 시간으로 변환 (1시간 = 3600초)
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
