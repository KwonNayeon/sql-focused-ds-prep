-- ============================================================
-- [트러블슈팅 노트] Stock Monthly Highest/Lowest Open Prices
-- Filename: stock_highest_lowest_months.sql
-- 
-- [1] 목표:
--   - stock_prices 테이블에서 각 주식(ticker)별 
--   - 가장 높은/낮은 open 가격이 있는 달(month)을 추출
--   - 날짜 형식을 'Mon-YYYY' 형태로 변환
--
-- [2] 문제 상황과 해결 과정:
--   - CTE와 ROW_NUMBER() 적용:
--      - highest/lowest prices를 별도 CTE로 분리
--      - ROW_NUMBER()로 각 ticker별 순위 부여
--      - row_num = 1 조건으로 최고/최저값 필터링
--
-- [3] 학습 포인트:
--   - ROW_NUMBER() 활용법:
--     * PARTITION BY ticker: 각 주식별로 분리
--     * ORDER BY open DESC/ASC: 가격 기준 순위 부여
--   - 날짜 형식 변환:
--     * TO_CHAR(date, 'Mon-YYYY') 활용
--   - CTE를 통한 쿼리 구조화:
--     * 복잡한 쿼리를 논리적 단위로 분리
-- ============================================================
WITH highest_prices AS (
    SELECT 
        ticker,
        TO_CHAR(date, 'Mon-YYYY') as highest_mth,
        open as highest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open DESC) as row_num
    FROM stock_prices
), 
lowest_prices AS (
    SELECT 
        ticker,
        TO_CHAR(date, 'Mon-YYYY') as lowest_mth,
        open as lowest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open ASC) as row_num
    FROM stock_prices
)
SELECT 
    highest.ticker,
    highest.highest_mth,
    highest.highest_open,
    lowest.lowest_mth,
    lowest.lowest_open
FROM highest_prices as highest 
INNER JOIN lowest_prices AS lowest 
    ON highest.ticker = lowest.ticker 
    AND highest.row_num = 1
    AND lowest.row_num = 1
ORDER BY highest.ticker;
