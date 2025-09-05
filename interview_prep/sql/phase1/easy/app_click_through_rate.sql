-- ============================================================
-- [쿼리 설명] App Click-through Rate (CTR)
-- Filename: app_click_through_rate.sql
-- 
-- [1] 목표:
--   - 2022년 각 앱의 CTR(Click-through Rate) 계산
--   - CTR = (클릭 수 / 노출 수) * 100
--
-- [2] 문제 해결 과정:
--   1. 연도 데이터 추출:
--      - EXTRACT로 timestamp에서 year 추출
--      
--   2. 이벤트 타입 변환:
--      - impression, click을 CASE문으로 1,0으로 변환
--      - 2022년 데이터만 필터링
--   
--   3. CTR 계산:
--      - 앱별로 impression, click 합계 집계
--      - 정수 나눗셈 오류 방지를 위해 100.0 곱하기
--
-- [3] 학습 포인트:
--   - PostgreSQL 정수 나눗셈 처리:
--     * 100 대신 100.0을 곱해 부동 소수점 계산
--   - CASE 문으로 이벤트 카운팅:
--     * Boolean 대신 1,0 사용으로 SUM 가능
-- ============================================================

WITH yearly_events AS (
   SELECT 
       *,
       EXTRACT(YEAR FROM timestamp) AS year
   FROM events
),
event_flags AS (
   SELECT
       CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END AS impression,
       CASE WHEN event_type = 'click' THEN 1 ELSE 0 END AS click,
       *
   FROM yearly_events
   WHERE year = 2022
),
event_sums AS (
   SELECT
       app_id,
       SUM(impression) AS sum_impression,
       SUM(click) AS sum_click
   FROM event_flags
   GROUP BY app_id
)
SELECT 
   app_id,
   ROUND(100.0 * sum_click / sum_impression, 2) AS ctr
FROM event_sums;
