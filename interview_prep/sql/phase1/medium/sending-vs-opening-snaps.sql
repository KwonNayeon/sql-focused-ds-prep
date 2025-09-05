-- 조건부 합계: SUM(CASE WHEN column_name = '특정값' THEN amount_column ELSE 0 END)
with data as (
  select
    ab.age_bucket,
    a.activity_type,
    a.time_spent
  from activities a 
  join age_breakdown ab on a.user_id = ab.user_id
)
select
  age_bucket,
  round((sum(case when activity_type = 'send' then time_spent else 0 end) / (sum(case when activity_type = 'send' then time_spent else 0 end) + sum(case when activity_type = 'open' then time_spent else 0 end))) * 100.0, 2) as send_perc,
  round((sum(case when activity_type = 'open' then time_spent else 0 end) / (sum(case when activity_type = 'send' then time_spent else 0 end) + sum(case when activity_type = 'open' then time_spent else 0 end))) * 100.0, 2) as open_perc
from data
group by age_bucket
;