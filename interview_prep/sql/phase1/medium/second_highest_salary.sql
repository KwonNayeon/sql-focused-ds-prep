select
  salary
from (
  select
    *,
    rank() over(order by salary desc) as rk
  from employee
) ranked
where rk = 2
;

-- Review Notes:
-- 2026-07-27: 복습
-- 2026-07-31: 복습

