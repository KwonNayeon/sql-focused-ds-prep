-- 복습 필요: 날짜 간격 계산, EXTRACT vs 직접 빼기 차이점
-- 포인트: MAX(date) - MIN(date)가 더 간단함
select
  user_id,
  max(post_date::date) - min(post_date::date) as days_between
from posts
where extract(year from post_date) = 2021
group by user_id
having count(*) >= 2
;