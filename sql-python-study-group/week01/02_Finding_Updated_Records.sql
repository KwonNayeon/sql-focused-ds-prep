with data as(
    select
     id,
     first_name,
     last_name,
     department_id,
     salary,
     row_number() over (partition by id order by salary desc) as rn
    from ms_employee_salary
)
select
    id,
    first_name,
    last_name,
    department_id,
    salary
from data
where rn = 1