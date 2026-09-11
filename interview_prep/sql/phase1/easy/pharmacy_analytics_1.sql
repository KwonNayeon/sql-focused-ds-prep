SELECT
  drug,
  total_sales - cogs as total_profit
FROM pharmacy_sales
order by total_profit desc
limit 3
;

-- Review Notes:
-- 2026-09-11: 복습 완료, 문제 제대로 읽기
