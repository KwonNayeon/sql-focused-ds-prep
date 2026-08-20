-- ============================================================
-- [트러블슈팅 노트] International Call 비율 계산
-- Filename: international_call_percentage.sql
-- 
-- [1] 목표:
--   - 전체 통화 중 international call의 비율을 계산
--   - 발신자와 수신자의 국가가 다른 경우를 international call로 정의
--
-- [2] JOIN 전략:
--   - phone_info 테이블을 두 번 JOIN하여 발신/수신 국가 정보 획득
--   - caller JOIN: 발신자의 국가 정보
--   - receiver JOIN: 수신자의 국가 정보
-- ============================================================

-- 풀이 1
with cte as (
  select
    caller.country_id as caller_country,
    receiver.country_id as receiver_country
  from phone_calls calls
  left join phone_info caller
  on calls.caller_id = caller.caller_id
  left join phone_info receiver
  on calls.receiver_id = receiver.caller_id
)
select
  round(count(case when caller_country != receiver_country then 1 end)*1.0/count(*)*100, 1) as international_call_pct
from cte
;

-- 솔루션
SELECT
 round(
   100.0 * sum(case when caller.country_id <> receiver.country_id 
     then 1 else 0 end)
   /count(*), 1
 ) as international_call_pct
from phone_calls as calls
left join phone_info as caller
 on calls.caller_id = caller.caller_id
left join phone_info as receiver
 on calls.receiver_id = receiver.caller_id
;

-- Review Notes:
-- 2026-08-20: 퍼센트 계산할 때 sum(), count() 둘 다 가능, 문법만 조금 다름
