-- ============================================================
-- [트러블슈팅 노트] Patient Support Analysis (Part 1)
-- Filename: patient_support_analysis_1.sql
-- 
-- [1] 목표:
--   - 3회 이상 통화한 보험 가입자 수 계산
--   - case_id로 통화 횟수 카운트
--   - policy_holder_id로 가입자 구분
--
-- [2] 문제 상황과 해결 과정:
--   1) 초기 문제점:
--      - WHERE절에서 COUNT 사용 시도 (실행 순서상 불가능)
--   
--   2) 해결 방안:
--      - HAVING절 사용하여 그룹화 후 필터링
--
-- [3] 코드 개선사항 (가독성):
--   - CTE 이름을 'data'에서 'frequent_callers'로 변경
--   - 결과 칼럼명을 더 직관적으로 수정
--
-- [3] 학습 포인트:
--   - WHERE vs HAVING의 실행 순서와 용도
--   - CTE를 활용한 중첩 집계 처리
-- ============================================================

WITH frequent_callers AS (
  SELECT
    policy_holder_id,
    COUNT(case_id) as call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
)
SELECT
  COUNT(*) as policy_holder_count
FROM frequent_callers;
