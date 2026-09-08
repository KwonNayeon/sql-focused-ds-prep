select
  emp.employee_id,
  emp.name as employee_name
from employee as mgr
inner join employee as emp
on mgr.employee_id = emp.manager_id
where mgr.salary < emp.salary

-- Review Notes:
-- 2026-09-08: join = inner join
