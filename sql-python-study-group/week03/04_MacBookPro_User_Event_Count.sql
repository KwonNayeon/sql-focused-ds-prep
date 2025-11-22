-- 이벤트 발생 횟수를 알고 싶다면, DISTINCT 없이
-- 몇 명의 유저가 이벤트를 발생시켰는지 알고 싶다면, DISTINCT 사용
select
    event_name,
    count(case when device = 'macbook pro' then user_id end) as cnt
from playbook_events
group by event_name
having count(case when device = 'macbook pro' then user_id end) > 0
order by count(case when device = 'macbook pro' then user_id end) desc
;
