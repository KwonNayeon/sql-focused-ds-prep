-- Percentage of click-through rate (CTR)
-- = 100.0 * Number of clicks / Number of impressions
-- 'event_type'은 문자열 리터럴. 컬럼명에는 따옴표를 쓰면 안 됨.
select
  app_id,
  round(100.0 * count(case when event_type = 'click' then 1 end)
        / count(case when event_type = 'impression' then 1 end), 2) as ctr
from events
where extract(year from timestamp) = 2022
group by app_id
;