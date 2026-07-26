-- Income by Title and Gender
-- 중요 조건: "disregard employees without bonuses in your calculation" → 보너스 없는 직원은 제외
with cte as (
    select
        a.worker_ref_id,
        b.employee_title,
        b.sex,
        sum(a.bonus) as total_bonus,
        b.salary
    from sf_bonus a
    left join sf_employee b
    on a.worker_ref_id = b.id
    group by a.worker_ref_id, b.employee_title, b.sex, b.salary
)
select
    employee_title,
    sex as gender,
    avg(total_bonus+salary) as avg_income
from cte
group by employee_title, sex
;

-- Review Notes:
-- 2025-11-27: 복습 필수
-- 2026-07-26: 복습
