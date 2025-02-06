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

-- My answer
with data as (
 SELECT
   sum(case when caller.country_id <> receiver.country_id 
     then 1 else 0 end) as international_calls,
   count(*) as total_calls
 from phone_calls as calls
 left join phone_info as caller
   on calls.caller_id = caller.caller_id
 left join phone_info as receiver
   on calls.receiver_id = receiver.caller_id
)
SELECT
 round(100.0 * international_calls::decimal/total_calls, 1) as international_calls_pct
from data

-- Solution
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
