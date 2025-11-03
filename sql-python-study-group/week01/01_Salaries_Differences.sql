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