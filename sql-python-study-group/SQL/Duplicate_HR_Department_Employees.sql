select
    first_name,
    department
from worker
where department='HR'

union all

select
    first_name,
    department
from worker
where department='HR'
;
