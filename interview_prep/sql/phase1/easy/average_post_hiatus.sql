-- 내 풀이
with date as (
  SELECT
    user_id,
    post_id,
    date(post_date) as date
  FROM posts
  where extract(year from post_date) = 2021
)
select
  user_id,
  max(date) - min(date) as days_between
from date
group by user_id
having count(post_id) >= 2
;

-- 개선된 풀이 (cte 없이도 풀 수 있음)
SELECT 
	user_id, 
    MAX(post_date::DATE) - MIN(post_date::DATE) AS days_between
FROM posts
WHERE DATE_PART('year', post_date::DATE) = 2021 
GROUP BY user_id
HAVING COUNT(post_id)>1
;
