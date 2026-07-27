select
    department,
    first_name,
    salary
from (
    select
        department,
        first_name,
        salary,
        rank() over (partition by department order by salary desc) as rk
    from employee
)
where rk = 1
;

-- Review Notes:
-- 2026-07-27: 복습
