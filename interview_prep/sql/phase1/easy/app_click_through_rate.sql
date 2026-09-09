-- 풀이 1
WITH yearly_events AS (
   SELECT 
       *,
       EXTRACT(YEAR FROM timestamp) AS year
   FROM events
),
event_flags AS (
   SELECT
       CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END AS impression,
       CASE WHEN event_type = 'click' THEN 1 ELSE 0 END AS click,
       *
   FROM yearly_events
   WHERE year = 2022
),
event_sums AS (
   SELECT
       app_id,
       SUM(impression) AS sum_impression,
       SUM(click) AS sum_click
   FROM event_flags
   GROUP BY app_id
)
SELECT 
   app_id,
   ROUND(100.0 * sum_click / sum_impression, 2) AS ctr
FROM event_sums;

-- 풀이 2
SELECT
  app_id,
  round(count(case when event_type = 'click' then 1 end) * 100.0 / count(case when event_type = 'impression' then 1 end), 2) as ctr
FROM events
where extract(year from timestamp) = 2022
group by app_id
;
