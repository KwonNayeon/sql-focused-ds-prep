-- 내 풀이
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

-- 다른 풀이
select
  extract(month from event_date) as month,
  count(distinct user_id) as monthly_active_users
from user_actions
where user_id in (
  select distinct user_id
  from user_actions
  where extract(month from event_date) = 6 and extract(year from event_date) = 2022
  )
  and extract(month from event_date) = 7 and extract(year from event_date) = 2022
group by extract(month from event_date)
;

-- Review Notes:
-- 2026-08-24: 다른 풀이도 살펴보기
-- 2026-08-25: Discussion에 있던 풀이 복습함
