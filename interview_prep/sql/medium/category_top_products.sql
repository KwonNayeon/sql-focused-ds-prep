-- ============================================================
-- [트러블슈팅 노트] Highest-Grossing Items
-- Filename: category_top_products.sql
-- 
-- [1] 목표:
--   - product_spend 테이블에서 카테고리별 최고 매출 제품 2개씩 추출
--   - 2022년도 데이터만을 대상으로 분석 수행
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근법 구상:
--      - ORDER BY와 LIMIT 사용 시도
--      - 단순 정렬로는 카테고리별 상위 제품 추출 불가
--      
--   2. 해결을 위한 단계별 접근:
--      - WITH절을 사용하여 중간 집계 테이블 생성
--      - GROUP BY로 제품별 총 매출 집계
--      - ROW_NUMBER()로 카테고리별 순위 부여
--
-- [3] 주요 해결 포인트:
--   - 데이터 집계 시 주의사항:
--     * GROUP BY 누락 시 집계 함수(SUM) 사용 불가
--     * category, product로 그룹화하여 총 매출 계산
--   - 윈도우 함수 활용:
--     * PARTITION BY로 카테고리별 독립적 순위 부여
--     * ROW_NUMBER()로 매출액 기준 순위 계산
--   - 기간 필터링:
--     * EXTRACT(YEAR FROM transaction_date)로 2022년 데이터 추출
-- ============================================================

WITH product_total AS (
    SELECT 
        category,
        product,
        SUM(spend) as total_spend
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product      -- 이 부분이 필요합니다!
),
ranked AS (
    SELECT 
        category,
        product,
        total_spend,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spend DESC) as rn
    FROM product_total
)
SELECT
  category,
  product,
  total_spend
FROM ranked
WHERE rn <= 2;
