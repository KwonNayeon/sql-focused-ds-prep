with daily_sessions as (
    select
        user_id,
        EXTRACT(DAY FROM timestamp) as day,
        max(case when action = 'page_load' then timestamp end) as max_load,
        min(case when action = 'page_exit' then timestamp end) as min_exit
    from facebook_web_log
    group by 1,2
)
select
    user_id,
    avg(min_exit - max_load) as avg_session_duration
from daily_sessions
where min_exit is not null
    and max_load is not null
group by user_id
;

-- Review Notes:
-- 2025-11-08: 다시 풀어보기
-- 2025-11-10: case문 쓸 때 문법 여전히 헷갈림
