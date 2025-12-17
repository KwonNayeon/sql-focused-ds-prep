with cte as (
    select
        id,
        row_number() over (order by salary desc) as rn,
        salary
    from employee
)
select salary
from cte
where rn = 2
;
