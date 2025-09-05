-- ============================================================
-- [트러블슈팅 노트] Laptop vs. Mobile Viewership
-- Filename: laptop_vs_mobile_viewership.sql
-- 
-- [1] 목표:
--   - viewership 테이블에서 기기 타입별(mobile/laptop) 조회 수 집계
--   - mobile: tablet과 phone의 합계
--   - laptop: laptop 조회 수
--
-- [2] 문제 해결 과정:
--   1. 초기 시도 오류:
--      - COUNT(*)를 사용하려 했으나 부적절
--      - COUNT는 행의 수를 세는 함수로, 1/0 값의 합계를 구할 수 없음
--   
--   2. 해결 방법:
--      - CASE문으로 각 기기 타입을 1 또는 0으로 변환
--      - SUM으로 1의 개수를 합산하여 각 타입의 조회 수 계산
--
-- [3] 학습 포인트:
--   - COUNT vs SUM: 
--     * COUNT: 행의 개수를 세는 함수
--     * SUM: 실제 값들의 합계를 계산하는 함수
--   - CASE문으로 조건별 1/0 변환 후 SUM으로 집계하는 패턴
-- ============================================================

WITH data AS (
   SELECT
       CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END AS mobile,
       CASE WHEN device_type IN ('laptop') THEN 1 ELSE 0 END AS laptop
   FROM viewership
)
SELECT
   SUM(laptop) AS laptop_views,
   SUM(mobile) AS mobile_views
FROM data;
