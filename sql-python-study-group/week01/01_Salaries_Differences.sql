with data as (
    select
        d.department,
        max(e.salary) as max_salary
    from db_employee e
    join db_dept d on e.department_id = d.id
    where d.department in ('engineering', 'marketing')
    group by d.department
)
select
    abs(max(case when department = 'engineering' then max_salary end) -
    max(case when department = 'marketing' then max_salary end)) as salary_difference
from data

-- Review Notes:
-- 2025-11-03: 처음 풂, 각 dep별 필터링 헷갈림
-- 2025-11-04: case문을 이용해서 각 dep의 max값을 뺀다는 아이디어를 떠올리지 못함