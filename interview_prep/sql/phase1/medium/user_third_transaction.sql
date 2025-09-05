-- ============================================================
-- [트러블슈팅 노트] User's Third Transaction
-- Filename: user_third_transaction.sql
-- 
-- [1] 목표:
--   - 각 사용자별 시간순으로 세 번째 거래 내역 추출
--   - 사용자 ID, 거래 금액, 거래 일자 조회
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - 단순 ROW_NUMBER()만 사용하여 전체 데이터의 세 번째 행만 추출
--      - GROUP BY를 잘못 사용하여 원하는 결과를 얻지 못함
--      - 각 사용자별 세 번째 거래를 추출해야 하는 요구사항 파악 부족
--      
--   2. PARTITION BY 학습과 적용:
--      - ROW_NUMBER()에 PARTITION BY 구문 필요성 인지
--      - 사용자별로 독립적인 행 번호 부여 방법 이해
--      - 불필요한 GROUP BY 제거
--
-- [3] 학습 포인트:
--   - 윈도우 함수의 PARTITION BY 활용:
--     * 그룹별 독립적인 순번 부여 방법
--     * ROW_NUMBER()와 PARTITION BY의 조합 사례
--   - 서브쿼리 활용:
--     * 순번이 부여된 결과에서 조건 필터링
--     * 중첩 쿼리 구조의 이해와 활용
-- ============================================================
-- 첫 번째 풀이
SELECT 
    user_id, 
    spend, 
    transaction_date
FROM (
    SELECT
        user_id,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn,
        spend,
        transaction_date
    FROM transactions
) ranked
WHERE rn = 3;

-- 2025/02/17 풀이
WITH data AS (
   SELECT
       user_id,
       spend,
       transaction_date,
       ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn
   FROM transactions
)
SELECT
   user_id,
   spend,
   transaction_date
FROM data 
WHERE rn = 3
;
