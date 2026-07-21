with cte as (
    select
        map.manager_empl_id,
        avg(emp.salary) as avg_salary
    from map_employee_hierarchy map
    join dim_employee emp
    on map.empl_id = emp.empl_id
    where map.manager_empl_id is not null
    group by map.manager_empl_id
)
select
    emp.empl_id, 
    emp.salary,
    cte.avg_salary
from cte
left join dim_employee emp
on cte.manager_empl_id = emp.empl_id
where emp.salary < cte.avg_salary*2
;