with month as (
    select
        *,
        extract(month from joining_date) as month
    from worker
)
select
    count(worker_id) as n_admins
from month
where month >= 4 and department = 'Admin'
group by department
;
