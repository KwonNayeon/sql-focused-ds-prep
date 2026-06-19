select
    department
from employee
group by department
having count(distinct id) > 4
;
