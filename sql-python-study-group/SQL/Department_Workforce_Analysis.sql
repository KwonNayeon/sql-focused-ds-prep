select
    department,
    count(id) as headcount,
    sum(salary) as total_payroll,
    avg(salary) as avg_salary
from techcorp_workforce
where joining_date >= '2021-01-01'
group by department
having count(id) >= 5
;
