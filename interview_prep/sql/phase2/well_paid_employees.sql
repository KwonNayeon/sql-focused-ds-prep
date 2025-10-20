-- Self join: employee와 manager를 연결하여 비교
select
  e.employee_id,
  e.name
from employee e 
join employee m on e.manager_id = m.employee_id
where e.salary > m.salary
;