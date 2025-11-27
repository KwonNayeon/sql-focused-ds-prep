-- Income by Title and Gender
-- 중요 조건: "disregard employees without bonuses in your calculation" → 보너스 없는 직원은 제외
-- LEFT JOIN → INNER JOIN: 보너스 있는 직원만
-- COALESCE(b.total_bonus, 0) → b.total_bonus: NULL 걱정 없음
with bonus as (
    select
        worker_ref_id,
        sum(bonus) as total_bonus
    from sf_bonus
    group by worker_ref_id
),
total as (
    select
        e.employee_title,
        e.sex,
        e.salary + b.total_bonus as total
    from sf_employee e
    join bonus b on e.id = b.worker_ref_id
)
select
    employee_title,
    sex,
    avg(total)
from total
group by employee_title, sex

-- Review Notes:
-- 2025-11-27: 복습 필수
