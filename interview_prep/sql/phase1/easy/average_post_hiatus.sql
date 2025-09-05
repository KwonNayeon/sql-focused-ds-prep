-- ============================================================
-- [트러블슈팅 노트] Average Post Hiatus (Part 1)
-- Filename: average_post_hiatus.sql
-- 
-- [1] 목표:
--   - 2021년에 2회 이상 게시한 사용자별로
--   - 첫 게시물과 마지막 게시물 간의 일수 계산
--
-- [2] 문제 해결 과정:
--   1. 날짜 간격 계산 시행착오:
--      - 시도1: EXTRACT(days FROM post_date) 사용
--        → 실패: 월을 고려하지 않고 일자만 추출되는 문제
--      - 시도2: MAX(post_date) - MIN(post_date) 사용
--        → 성공했으나 interval 형식으로 반환되는 문제 발생
--      - 최종: EXTRACT(days FROM (MAX(post_date) - MIN(post_date)))
--        → 깔끔하게 일수만 추출
--   
--   2. 조건 처리:
--      - WHERE절에서 COUNT(*) 사용 시도 → 실패
--      - HAVING절로 이동하여 해결
--
-- [3] 학습 포인트:
--   - PostgreSQL 날짜 처리:
--     * 날짜 차이는 interval 타입 반환
--     * EXTRACT로 원하는 부분만 추출 가능
--   - GROUP BY 관련 조건:
--     * 집계 함수 조건은 HAVING 사용
--     * WHERE는 집계 전 필터링에 사용
-- ============================================================

WITH year AS (
   SELECT
       EXTRACT(YEAR FROM post_date) AS year,
       *
   FROM posts
),
year_2021 AS (
   SELECT
       user_id,
       EXTRACT(DAYS FROM MAX(post_date) - MIN(post_date)) AS post_date,
       COUNT(*) AS cnt
   FROM year
   WHERE year = 2021 
       AND post_date IS NOT NULL
   GROUP BY user_id
   HAVING COUNT(*) >= 2
)
SELECT 
   user_id, 
   post_date
FROM year_2021;
