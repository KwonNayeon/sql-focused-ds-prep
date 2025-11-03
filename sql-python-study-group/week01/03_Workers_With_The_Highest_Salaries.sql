-- ROW_NUMBER(): 동점 미포함
-- RANK(): 동점 모두 포함 (1,1,1,4...)
-- DENSE_RANK(): 동점 모두 포함 (1,1,1,2...)
with data as(
    select
        w.salary,
        rank() over (order by w.salary desc) as rn,
        t.worker_title as best_paid_title
    from worker w
    join title t on w.worker_id = t.worker_ref_id
)
select
    best_paid_title
from data
where rn = 1
