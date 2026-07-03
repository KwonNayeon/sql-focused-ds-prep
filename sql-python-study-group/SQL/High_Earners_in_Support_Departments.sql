select
    first_name, last_name, department, salary
from techcorp_workforce
where department in ('HR', 'Admin')
    and salary > 80000
;
