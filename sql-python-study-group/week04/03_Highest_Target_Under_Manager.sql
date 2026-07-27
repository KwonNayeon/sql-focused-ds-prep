-- Highest Target Under Manager

select
    first_name,
    target
from (
    select
        first_name,
        target,
        rank() over (partition by manager_id order by target desc) as rk
    from salesforce_employees
    where manager_id=13
)
where rk = 1

-- 다른 풀이
with cte as (
    select
        first_name,
        target,
        rank() over (partition by manager_id order by target desc) as rk
    from salesforce_employees
    where manager_id = 13
)
select
    first_name,
    target
from cte
where rk=1
;

-- Review Notes:
-- 2025-11-28: Window Function은 HAVING에서 직접 쓸 수 없음. 서브쿼리에서 rank를 계산 -> 외부 쿼리에서 WHERE rn = 1로 필터링
-- 2026-07-27: 복습

