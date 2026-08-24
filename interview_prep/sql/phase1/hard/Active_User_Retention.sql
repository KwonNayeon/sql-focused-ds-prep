with jun as (
  SELECT
    distinct user_id
  FROM user_actions
  where event_date >= '2022-06-01' and event_date < '2022-07-01'
  and event_type in ('like', 'sign-in', 'comment')
),
july as (
  SELECT
    distinct user_id,
    extract(month from event_date) as month
  FROM user_actions
  where event_date >= '2022-07-01' and event_date < '2022-08-01'
  and event_type in ('like', 'sign-in', 'comment')
)
select
  july.month,
  count(distinct july.user_id) as monthly_active_users
from jun
join july
on jun.user_id = july.user_id
group by july.month
;

-- Review Notes:
-- 2026-08-24: 다른 풀이도 살펴보기
