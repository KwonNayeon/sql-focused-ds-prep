with cte as (
    select
        department,
        first_name,
        max(salary) over (partition by department order by salary desc) as highest_salary,
        rank() over (partition by department order by salary desc) as rn
    from employee
)
select
    department,
    first_name,
    highest_salary
from cte
where rn = 1
;
