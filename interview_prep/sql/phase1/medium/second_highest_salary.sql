-- ============================================================
-- [트러블슈팅 노트] Second Highest Salary
-- Filename: second_highest_salary.sql
-- 
-- [1] 목표:
--   - employee 테이블에서 두 번째로 높은 급여 값을 추출
--   - 중복된 급여는 제외하고 순수하게 두 번째로 높은 값을 찾아야 함
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - ROW_NUMBER()를 잘못 사용한 시도
--      - PARTITION BY를 불필요하게 사용
--      - 윈도우 함수의 결과를 WHERE절에서 직접 필터링하려 시도
--      
--   2. LIMIT/OFFSET 학습과 적용:
--      - 중복 제거(DISTINCT)의 필요성 인지
--      - ORDER BY로 정렬 후 OFFSET으로 첫 번째 값을 건너뛰는 방법 이해
--      - LIMIT 1로 단일 결과 추출
--
-- [3] 학습 포인트:
--   - LIMIT/OFFSET 활용법:
--     * OFFSET n: 처음 n개 행을 건너뛰기
--     * LIMIT n: 상위 n개 행만 선택
--   - 중복 처리의 중요성:
--     * DISTINCT를 통한 중복 급여 제거
--     * 정확한 순위 산출을 위한 전처리
-- ============================================================

-- 첫 번째 풀이
WITH data AS (
   SELECT DISTINCT salary
   FROM employee
   ORDER BY salary DESC
   LIMIT 1 OFFSET 1
)
SELECT * 
FROM data;

-- 2025/02/10 풀이
with data as (
  SELECT
    dense_rank() over (order by salary desc) as rn,
    salary
  from employee
)
SELECT
  salary
from data
where rn = 2
;
