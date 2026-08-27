-- 풀이 1
WITH yearly_tweets AS (
   SELECT 
       *, 
       EXTRACT(YEAR FROM tweet_date) AS year
   FROM tweets
),
tweet_count AS (
   SELECT
       user_id,
       COUNT(*) AS cnt
   FROM yearly_tweets
   WHERE year = 2022
   GROUP BY user_id
)
SELECT 
   cnt AS tweet_bucket,
   COUNT(*) AS users_num
FROM tweet_count
GROUP BY cnt
ORDER BY cnt;

-- 풀이 2
with cte as (
  select
    user_id,
    count(tweet_id) as tweet_cnt
  from tweets
  where extract(year from tweet_date) = 2022
  group by user_id
)
select
  tweet_cnt as tweet_bucket,
  count(user_id) as users_num
from cte
group by tweet_cnt
order by tweet_cnt
;
