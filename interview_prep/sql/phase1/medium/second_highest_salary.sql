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

-- 2026/07/27 풀이
select
    salary
from (
    select
        *,
        rank() over (order by salary desc) as rk
    from employee
)
where rk = 2
;

-- Review Notes:
-- 2026-07-27: 복습
