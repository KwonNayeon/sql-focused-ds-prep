select
  coalesce(a.user_id, b.user_id) as user_id,
  case when b.paid is null then 'CHURN'
       when a.user_id is null then 'NEW'
       when a.status = 'CHURN' then 'RESURRECT'
       else 'EXISTING' end
from advertiser a
full outer join daily_pay b
on a.user_id = b.user_id
order by user_id
;

-- Review Notes:
-- 2026-09-02: 실수한 부분 - 새로운 고객의 경우 advertiser 테이블에 고객정보가 없을 수도 있음, 이 경우를 고려하지 못함
