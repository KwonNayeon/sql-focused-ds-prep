-- ============================================================
-- [트러블슈팅 노트] Second Day Confirmation
-- Filename: second_day_confirmation.sql
-- 
-- [1] 목표:
--   - 가입일 다음날에 확인 문자를 받은
--   - 사용자 ID 추출
--
-- [2] 문제 상황과 해결 과정:
--   1. timestamp 간 차이 계산 시행착오:
--      - 시도1: LAG 함수 사용 고려
--        → LAG는 같은 컬럼의 이전 행과의 비교에 사용
--        → 이 경우는 단순히 두 날짜 간의 차이를 계산하면 되는 상황
--      - 시도2: DATE_PART('day', action_date - signup_date) 사용
--        → 깔끔하게 일수 차이만 추출 가능
--      
--   2. 데이터 결합:
--      - emails와 texts 테이블을 LEFT JOIN으로 연결
--      - email_id를 기준으로 매칭
--
-- [3] 학습 포인트:
--   - PostgreSQL timestamp 처리:
--     * 두 timestamp 간의 차이는 interval 타입 반환
--     * DATE_PART로 원하는 단위(일수)만 추출 가능
--   - LAG vs DATE_PART:
--     * LAG: 이전 행과의 비교에 적합
--     * DATE_PART: 같은 행의 다른 컬럼 간 차이 계산에 적합
-- ============================================================

WITH email_text_joined AS (
   SELECT *
   FROM emails A
   LEFT JOIN texts B
       ON A.email_id = B.email_id
)
SELECT 
   user_id
FROM email_text_joined
WHERE DATE_PART('day', action_date - signup_date) = 1;
