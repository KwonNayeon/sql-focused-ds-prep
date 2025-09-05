with data as (
select
  count(distinct tweet_id) as tweet_bucket,
  extract(year from tweet_date) as year,
  user_id
from tweets
group by user_id, year
)
select
  tweet_bucket,
  count(*) as users_num
from data
where year = 2022
group by tweet_bucket
;