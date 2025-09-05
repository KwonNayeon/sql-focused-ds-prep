-- ============================================================
-- [쿼리 설명] 도시별 주문 완료 건수 TOP 3
-- Filename: cities_with_completed_trades.sql
-- 
-- [1] 목적:
--   - 도시별로 완료된 주문 수를 집계하여
--   - 주문이 가장 많은 상위 3개 도시 추출
-- ============================================================

SELECT 
    city,
    COUNT(*) AS total_orders
FROM trades A
LEFT JOIN users B
    ON A.user_id = B.user_id
WHERE 
    status = 'Completed'
GROUP BY 
    city
ORDER BY 
    total_orders DESC
LIMIT 3;
