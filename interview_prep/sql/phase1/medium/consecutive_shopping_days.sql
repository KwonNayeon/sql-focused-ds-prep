-- ============================================================
-- [문제 해결] Sequential 3일 연속 거래가 있는 유저 찾기
-- 
-- [1] 해결 방법:
--   - JOIN을 두 번 사용하여 연속된 3일의 거래를 찾음
--   - 각 JOIN마다 날짜가 1일씩 차이나는 조건 사용
--   - DISTINCT로 중복된 유저 제거 (4일 이상 연속 거래의 경우 중복 발생)
--
-- [2] 코드 설명:
--   - t1: 첫째 날 거래
--   - t2: 둘째 날 거래 (t1 + 1일)
--   - t3: 셋째 날 거래 (t2 + 1일)
-- ============================================================

WITH data AS (
   SELECT
       t1.user_id
   FROM transactions AS t1
   JOIN transactions AS t2
       ON date(t2.transaction_date) = date(t1.transaction_date) + 1
   JOIN transactions AS t3
       ON date(t3.transaction_date) = date(t2.transaction_date) + 1
)
SELECT
   DISTINCT user_id
FROM data
ORDER BY 
   user_id ASC;
