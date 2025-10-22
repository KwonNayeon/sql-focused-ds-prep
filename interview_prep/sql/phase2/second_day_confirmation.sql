-- 날짜 형식: 06/14/2022 00:00:00
-- 시간 부분을 무시하고 날짜만 비교하고 싶을 때 ::date 사용
select
  user_id
from emails e 
join texts t on e.email_id = t.email_id
where signup_action = 'Confirmed'
  and action_date::date - signup_date::date = 1
;