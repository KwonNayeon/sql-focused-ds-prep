-- ============================================================
-- [트러블슈팅 노트] TikTok 활성화율 분석
-- Filename: tiktok_activation_rate.sql
-- 
-- [1] 문제 상황과 해결 과정:
--   1. JOIN 방식 선택 이슈:
--      - INNER JOIN을 사용했다가 emails 테이블의 전체 사용자를 포함하지 못하는 문제 발생
--      - LEFT JOIN으로 수정하여 emails 테이블의 모든 사용자 포함하도록 해결
--      
--   2. ID 기준 선택 고민:
--      - user_id vs email_id 중 집계 기준 선택 필요
--      - 테이블간 연결키가 email_id인 점을 확인
--      - emails와 texts 테이블이 email_id로 연결된 구조 파악 
--      - email_id 기준으로 집계하기로 결정
--
--   3. 정수 나눗셈 문제:
--      - 나눗셈 결과가 정수로만 나오는 문제 발생 
--      - CAST(SUM(is_activated) AS DECIMAL) 사용하여 소수점 결과 도출
--
-- [2] 핵심 학습 포인트:
--   1. JOIN 선택시 기준점 파악이 중요
--      - 분석 대상(emails 테이블)이 기준이면 LEFT JOIN 사용
--
--   2. 집계 키 선택은 테이블 구조 기반으로 판단
--      - 테이블간 연결 구조 확인
--      - 실제 데이터가 연결된 키 위주로 집계
--
--   3. 나눗셈 연산시 데이터 타입 주의
--      - 정수 나눗셈을 피하기 위한 DECIMAL 변환 필요
-- ============================================================

with data as (
  select
    e.email_id,
    case when max(case when t.signup_action = 'Confirmed' then 1 else 0 end) = 1
        then 1 else 0 end as is_activated
  from emails e 
  left join texts t on e.email_id = t.email_id
  group by e.email_id
)
select
  round(cast(sum(is_activated) as decimal) / count(*), 2) as confirm_rate
from data
