-- ============================================================
-- [트러블슈팅 노트] Department Top 3 Salaries
-- Filename: dept_top_3_salaries.sql
-- 
-- [1] 목표:
--   - 각 부서별 상위 3개의 급여를 받는 직원 정보 추출
--   - 부서명, 직원명, 급여를 정렬 조건에 맞게 출력
--   - 결과는 부서명 오름차순, 급여 내림차순, 이름 오름차순으로 정렬
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - "top three salaries"의 의미 해석 차이
--      - 동일 급여 처리 방식에 대한 고민
--      - 윈도우 함수 선택의 중요성 인지
--      
--   2. 윈도우 함수 학습과 적용:
--      - ROW_NUMBER vs DENSE_RANK 차이점 이해
--      - 동일 급여 처리 방식에 따른 결과 차이 파악
--      - JOIN을 통한 부서 정보 연결 방법 적용
--
-- [3] 학습 포인트:
--   - 윈도우 함수의 특성 이해:
--     * ROW_NUMBER(): 동일값도 순차적 순위
--     * DENSE_RANK(): 동일값 같은 순위, 연속적 순위
--   - 문제 해석의 중요성:
--     * 요구사항의 정확한 해석
--     * 중복 처리 방식 결정
-- ============================================================

-- Solution 1 (ROW_NUMBER 접근)
WITH data AS (
   SELECT
       name,
       department_id,
       salary,
       ROW_NUMBER() OVER (
           PARTITION BY department_id 
           ORDER BY salary DESC
       ) as rank
   FROM employee
)
SELECT
   B.department_name,
   A.name,
   A.salary
FROM data A
JOIN department B 
   ON A.department_id = B.department_id
WHERE rank <= 3
ORDER BY 
   department_name ASC, 
   salary DESC, 
   name ASC;

-- Solution 2 (DENSE_RANK 접근 - 문제 제시 답안)
WITH data AS (
   SELECT
       name,
       department_id,
       salary,
       DENSE_RANK() OVER (
           PARTITION BY department_id 
           ORDER BY salary DESC
       ) as rank
   FROM employee
)
SELECT
   B.department_name,
   A.name,
   A.salary
FROM data A
JOIN department B 
   ON A.department_id = B.department_id
WHERE rank <= 3
ORDER BY 
   department_name ASC, 
   salary DESC, 
   name ASC;
