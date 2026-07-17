select
    a.worker_id,
    a.first_name,
    a.salary
from worker a
join worker b on a.salary = b.salary and a.worker_id != b.worker_id
order by a.salary desc
;
