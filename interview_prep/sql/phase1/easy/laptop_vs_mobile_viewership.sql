-- 풀이 1
WITH data AS (
   SELECT
       CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END AS mobile,
       CASE WHEN device_type IN ('laptop') THEN 1 ELSE 0 END AS laptop
   FROM viewership
)
SELECT
   SUM(laptop) AS laptop_views,
   SUM(mobile) AS mobile_views
FROM data
;

-- 풀이 2
SELECT
  count(case when device_type = 'laptop' then 1 end) as laptop_views,
  count(case when device_type in ('tablet', 'phone') then 1 end) as mobile_views
FROM viewership
;

-- Review Notes:
-- 2026-09-02: 복습 완료
