with cte as (
  SELECT
    b.department_name,
    a.name,
    a.salary,
    dense_rank() over (partition by b.department_id order by a.salary desc) as rk
  FROM employee a
  join department b
  on a.department_id = b.department_id
)
select
  department_name,
  name,
  salary
from cte
where rk in (1,2,3)
order by department_name asc, salary desc, name asc
;

-- Review Notes:
-- 2026-08-04: 복습
