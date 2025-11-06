select
    department,
    first_name,
    salary,
    avg(salary) over (partition by department) as avg_salary
from employee

-- Review Notes:
-- 2025-11-05: 처음 풂, 비교적 쉬운 문제
-- 2025-11-06: 복습 완료
