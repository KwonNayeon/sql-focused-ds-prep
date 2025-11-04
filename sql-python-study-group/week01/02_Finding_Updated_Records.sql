-- 가장 높은 salary를 현재 salary로 가정
-- 각 직원별로 salary rank를 매겨서 가장 처음 값을 추출할 것
-- 이 문제의 경우 row_number, rank, dense_rank 모두 동일한 결과
with data as(
    select
     id,
     first_name,
     last_name,
     department_id,
     salary,
     row_number() over (partition by id order by salary desc) as rn
    from ms_employee_salary
)
select
    id,
    first_name,
    last_name,
    department_id,
    salary
from data
where rn = 1

-- Review Notes:
-- 2025-11-03: 처음 풂, group by 없이 max 값을 추출하는 법을 몰랐음
-- 2025-11-04: row_number() 문법 틀림