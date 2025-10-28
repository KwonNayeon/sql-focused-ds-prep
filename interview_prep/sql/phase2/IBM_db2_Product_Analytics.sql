-- DISTINCT: 유니크 쿼리만 카운트 (NULL의 경우 0 반환)
with data as (
  select
    e.employee_id,
    count(distinct q.query_id) as unique_queries
  from employees e 
  left join queries q on e.employee_id = q.employee_id
  and q.query_starttime >= '07/01/2023'
  and q.query_starttime < '10/01/2023'
  group by e.employee_id
)
select
  unique_queries,
  count(*) as employee_count
from data
group by unique_queries
order by unique_queries
;