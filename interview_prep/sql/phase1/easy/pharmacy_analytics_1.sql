-- ============================================================
-- [트러블슈팅 노트] Pharmacy Analytics (Part 1)
-- Filename: pharmacy_analytics_1.sql
-- 
-- [1] 목표:
--   - CVS Health의 가장 수익성 높은 상위 3개 약품과 
--   - 각각의 수익(total_profit) 추출
--
-- [2] 문제 상황과 해결 과정:
--   - 초기 쿼리에서 ORDER BY가 ASC로 되어 있어 최저 수익 약품이 출력
--   - DESC로 수정하여 highest to lowest 순서로 변경
--
-- [3] 학습 포인트:
--   - ORDER BY ASC/DESC의 차이
--   - 수익 계산: total_sales - cogs
-- ============================================================

SELECT
  drug,
  total_sales - cogs as total_profit
FROM pharmacy_sales
order by total_profit desc
limit 3
;
