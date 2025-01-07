-- ============================================================
-- [트러블슈팅 노트] Department Top 3 Salaries
-- Filename: dept_top_3_salaries.sql
-- 
-- [1] 목표:
--   - 각 부서별 상위 3개의 급여를 받는 직원 정보 추출
--   - 부서명, 직원명, 급여를 정렬 조건에 맞게 출력
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근 (ROW_NUMBER 사용):
--      - 동일 급여를 다른 순위로 처리
--      - 문제의 "top three salaries" 조건에 더 부합
--      예시: 7000(1), 4000(2), 4000(3), 3800(4) -> 3800 제외
--
WITH data AS (
   SELECT
       name,
       department_id,
       salary,
       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as rank
   FROM 
       employee
)
SELECT
   B.department_name,
   A.name,
   A.salary
FROM data A
JOIN department B ON A.department_id = B.department_id
WHERE rank <= 3
ORDER BY department_name ASC, salary DESC, name ASC;

--   2. 문제 해답 접근 (DENSE_RANK 사용):
--      - 동일 급여를 같은 순위로 처리
--      - 다음 순위를 연속적으로 부여
--      예시: 7000(1), 4000(2), 4000(2), 3800(3) -> 3800 포함
--
WITH data AS (
   SELECT
       name,
       department_id,
       salary,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as rank
   FROM 
       employee
)
SELECT
   B.department_name,
   A.name,
   A.salary
FROM data A
JOIN department B ON A.department_id = B.department_id
WHERE rank <= 3
ORDER BY department_name ASC, salary DESC, name ASC;

-- [3] 학습 포인트:
--   - 윈도우 함수의 특성 이해:
--     * ROW_NUMBER(): 동일값도 순차적 순위 (1,2,3,4)
--     * RANK(): 동일값 같은 순위, 다음 순위 건너뜀 (1,2,2,4)
--     * DENSE_RANK(): 동일값 같은 순위, 다음 순위 연속 (1,2,2,3)
--   
--   - 문제 해석의 중요성:
--     * "top three salaries"의 의미 해석 차이
--     * 중복 급여 처리 방식에 따른 결과 차이
--
--   - 정렬 조건의 정확한 구현:
--     * department_name ASC
--     * salary DESC
--     * name ASC
-- ============================================================
