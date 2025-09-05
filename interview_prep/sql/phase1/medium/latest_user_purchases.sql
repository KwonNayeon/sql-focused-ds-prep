-- ============================================================
-- [트러블슈팅 노트] Latest User Purchase Analysis
-- Filename: latest_user_purchases.sql
-- 
-- [1] 목표:
--   - 각 사용자의 가장 최근 거래일자와 해당 날짜의 구매 건수 추출
--   
-- [2] 주요 해결 포인트:
--   - ROW_NUMBER() 활용: 사용자별 최근 거래일자 순위 부여
--   - GROUP BY + COUNT: 같은 날짜의 구매 건수 집계
--   - 정렬 기준: 거래일자, 사용자ID 오름차순
-- ============================================================

WITH data AS (
 SELECT
   transaction_date,
   user_id,
   ROW_NUMBER() OVER (
     PARTITION BY user_id 
     ORDER BY transaction_date DESC
   ) AS num,
   COUNT(*) AS purchase_count
 FROM user_transactions
 GROUP BY transaction_date, user_id
)
SELECT
 transaction_date,
 user_id,
 purchase_count
FROM data
WHERE num = 1
ORDER BY transaction_date ASC, user_id ASC;
