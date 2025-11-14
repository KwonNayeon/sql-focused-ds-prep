-- step 1: 테이블 조인
-- step 2: 각 직원의 prorated salary 계산 (프로젝트 기간 * 연봉 / 365)
-- step 3: 프로젝트별로 총 인건비 합산
-- step 4: 예산 < 총 인건비인 프로젝트만 필터링
-- 출력: title, budget, prorated_employee_expense
with cte as (
    select
        p.title,
        p.budget,
        (p.end_date - p.start_date) as periods,
        e.salary
    from linkedin_employees e
    join linkedin_emp_projects ep on e.id = ep.emp_id
    join linkedin_projects p on ep.project_id = p.id
)
select
    title,
    budget,
    ceiling(sum(periods * salary/365.0)) as prorated_employee_expense
from cte
group by title, budget
having budget < ceiling(sum(periods * salary/365.0))
order by title
;

-- Review Notes:
-- 2025-11-14: 집계함수(SUM, AVG, COUNT 등)는 HAVING에서 사용
