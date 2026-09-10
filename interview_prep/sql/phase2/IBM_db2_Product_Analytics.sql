-- 풀이 1
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

-- 풀이 2
-- 주의할 것: 날짜 조건은 where절이 아니라 JOIN ... ON절에 넣어야 함. where절에 넣으면 쿼리를 조회하지 않은 직원들의 데이터가 조회되지 않음
with cte as (
  SELECT
    a.employee_id,
    count(b.employee_id) as cnt
  FROM employees a
  left join queries b
  on a.employee_id = b.employee_id
  and extract(year from query_starttime) = 2023
  and extract(month from query_starttime) > 6
  and extract(month from query_starttime) < 10
  group by a.employee_id
)
select
  cnt as unique_queries,
  count(employee_id) as employee_count
from cte
group by 1
order by 1
;
