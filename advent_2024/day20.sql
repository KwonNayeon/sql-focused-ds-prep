-- ============================================================
-- [트러블슈팅 노트] 미세먼지 계절별 통계 분석
-- 
-- [1] 목표:
--   - 미세먼지(pm10) 측정 데이터를 계절별로 분류하여
--   - 각 계절의 중앙값(median)과 평균값(average) 산출
--
-- [2] 문제 상황과 해결 과정:
--   1. 날짜 데이터 정제:
--      - SUBSTR로 measured_at에서 년월(YYYY-MM) 추출
--      - 추출된 월 정보로 계절 분류 (3-5월:봄, 6-8월:여름, 9-11월:가을, 그외:겨울)
--      
--   2. 중앙값 계산:
--      - PERCENTILE_CONT 함수 미지원으로 ROW_NUMBER() 활용
--      - 각 계절별로 데이터 정렬 후 중간값 추출
--      - 짝수개의 경우 중간 두 값의 평균 계산
--   
--   3. 최종 통계:
--      - 계절별 그룹화
--      - 중앙값과 소수점 둘째 자리까지 반올림한 평균값 계산
--
-- [3] 학습 포인트:
--   - WITH 절을 활용한 단계적 데이터 처리
--   - CASE WHEN으로 계절 분류 로직 구현
--   - Window 함수(ROW_NUMBER)로 중앙값 계산
--   - ROUND 함수로 평균값 소수점 처리
-- ============================================================

WITH month_extract AS (
   SELECT
       substr(measured_at, 1, 7) AS month,
       *
   FROM measurements
),
season_classify AS (
   SELECT
       CASE 
           WHEN month BETWEEN '2022-03' AND '2022-05' THEN 'spring'
           WHEN month BETWEEN '2022-06' AND '2022-08' THEN 'summer'
           WHEN month BETWEEN '2022-09' AND '2022-11' THEN 'autumn'
           ELSE 'winter'
       END AS season,
       *
   FROM month_extract
),
median_calculation AS (
   SELECT 
       season,
       pm10,
       ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10) AS row_num,
       COUNT(*) OVER (PARTITION BY season) AS total_rows
   FROM season_classify
)
SELECT 
   season,
   AVG(CASE 
       WHEN row_num IN ((total_rows + 1)/2, (total_rows + 2)/2) 
       THEN pm10 
   END) AS pm10_median,
   ROUND(AVG(pm10), 2) AS pm10_average
FROM median_calculation
GROUP BY season;
