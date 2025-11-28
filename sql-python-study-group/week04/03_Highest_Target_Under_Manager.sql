-- Highest Target Under Manager

select
    first_name,
    target
from (
    select
        first_name,
        target,
        rank() over (partition by manager_id order by target desc) as rn
    from salesforce_employees
    where manager_id=13
)
where rn = 1

-- Review Notes:
-- 2025-11-28: Window Function은 HAVING에서 직접 쓸 수 없음. 서브쿼리에서 rank를 계산 -> 외부 쿼리에서 WHERE rn = 1로 필터링
