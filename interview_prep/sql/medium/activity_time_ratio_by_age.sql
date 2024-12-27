-- ============================================================
-- [트러블슈팅 노트] Sending vs. Opening Snaps
-- Filename: activity_time_ratio_by_age.sql
-- 
-- [1] 목표:
--   - activities와 age_breakdown 테이블을 연결하여 연령대별 활동 시간 비율 분석
--   - activity_type(send/open)별 time_spent 비율을 연령대별로 계산
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근법 구상:
--      - activity_type 컬럼을 기준으로 조건부 합계 계산 필요
--      - 전체 시간 대비 각 활동 유형의 비율을 구해야 함
--      
--   2. 해결 방안:
--      - WITH 절을 사용하여 중간 집계 테이블 생성
--      - CASE WHEN을 활용하여 activity_type별 시간 합산
--      - 비율 계산 시 소수점 자리 ROUND 함수로 처리
--
-- [3] 학습 포인트:
--   - 조건부 집계 처리:
--     * CASE WHEN을 활용한 activity_type별 시간 합산
--     * SUM과 CASE WHEN의 조합으로 그룹별 부분합 계산
--   - 비율 계산 시 주의사항:
--     * 분모가 0이 되지 않도록 데이터 검증 필요
--     * 소수점 처리를 위한 ROUND 함수 활용
--   - 조인 관계:
--     * LEFT JOIN으로 모든 연령대 데이터 보존
-- ============================================================

WITH data AS (
  SELECT
    B.age_bucket,
    SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS total_sending,
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS total_opening
  FROM activities A
  LEFT JOIN age_breakdown B ON A.user_id = B.user_id
  GROUP BY B.age_bucket
)
SELECT
  age_bucket,
  ROUND((total_sending / (total_sending + total_opening)) * 100, 2) AS send_perc,
  ROUND((total_opening / (total_sending + total_opening)) * 100, 2) AS open_perc
FROM data;