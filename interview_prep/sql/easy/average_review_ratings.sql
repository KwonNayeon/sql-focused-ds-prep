-- ============================================================
-- [쿼리 설명] 월별/제품별 평균 평점 분석
-- Filename: average_review_ratings.sql
-- 
-- [1] 목적:
--   - 리뷰 데이터에서 월별, 제품별로
--   - 평균 평점을 소수점 2자리까지 계산
-- ============================================================

WITH monthly_reviews AS (
   SELECT
       EXTRACT(MONTH FROM submit_date) AS mth,
       product_id AS product,
       stars
   FROM reviews
)
SELECT 
   mth,
   product,
   ROUND(AVG(stars), 2) AS avg_stars
FROM monthly_reviews
GROUP BY 
   mth,
   product
ORDER BY 
   mth,
   product;
