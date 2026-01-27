-- where은 group by 이전에 와야 함
-- 날짜는 따옴표로 감싸야 함
select
    department,
    count(worker_id) as cnt
from worker
where joining_date >= '2014-04-01'
group by department
;
