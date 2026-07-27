select
    e.first_name,
    e.salary
from employee e
join employee m on e.manager_id = m.id
where e.salary > m.salary
;

-- Review Notes:
-- 2026-07-27: 복습, 푸는 방식을 떠올리는 게 어려움
