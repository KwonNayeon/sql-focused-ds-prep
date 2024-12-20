-- ============================================================
-- [트러블슈팅 노트] IBM DB2 Product Analytics
-- Filename: product_analytics.sql
-- 
-- [1] 목표:
--   - 7-9월 분기 동안 직원들의 쿼리 실행 분포 분석
--   - 쿼리 실행 횟수별 직원 수 파악 (미실행 직원 포함)
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근 실패:
--      - WHERE 절로 7-9월 데이터 필터링
--      → 쿼리 미실행 직원이 제외되는 문제 발생
--      
--   2. 문제 해결:
--      - employees 테이블을 기준으로 LEFT JOIN
--      - WHERE 대신 CASE문으로 조건 처리
--      - NULL 값을 0으로 변환하여 미실행 직원 포함
--
-- [3] 학습 포인트:
--   - NULL 값 처리:
--     * WHERE 절 사용 시 주의점
--     * CASE문을 활용한 NULL 처리 방법
--   - 데이터 기준점 설정:
--     * 전체 직원 포함을 위한 테이블 선택
--     * LEFT JOIN vs FULL JOIN 선택 기준
-- ============================================================

WITH employee_queries AS (
   SELECT
       A.employee_id,
       B.query_id,
       B.query_starttime
   FROM employees A
   LEFT JOIN queries B 
       ON A.employee_id = B.employee_id
),
query_flags AS (
   SELECT 
       employee_id,
       CASE
           WHEN query_starttime IS NULL THEN 0
           WHEN EXTRACT(month FROM query_starttime) BETWEEN 7 AND 9 THEN 1
           ELSE 0
       END AS valid_query
   FROM employee_queries
),
employee_query_counts AS (
   SELECT 
       employee_id,
       SUM(valid_query) AS query_count
   FROM query_flags
   GROUP BY employee_id
)
SELECT 
   query_count AS unique_queries, 
   COUNT(*) AS employee_count
FROM employee_query_counts
GROUP BY query_count
ORDER BY query_count;
