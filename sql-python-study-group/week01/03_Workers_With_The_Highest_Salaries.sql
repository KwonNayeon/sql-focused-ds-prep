-- ROW_NUMBER(): 동점 미포함
-- RANK(): 동점 모두 포함 (1,1,1,4...)
-- DENSE_RANK(): 동점 모두 포함 (1,1,1,2...)
-- WITH절 (CTE - Common Table Expression)
-- 가장 높은 salary를 가진 job title 추출하기
-- 문제 조건에서 동점을 포함하므로 rank() 사용
with data as(
    select
        w.salary,
        rank() over (order by w.salary desc) as rn,
        t.worker_title as best_paid_title
    from worker w
    join title t on w.worker_id = t.worker_ref_id
)
select
    best_paid_title
from data
where rn = 1

-- Review Notes:
-- 2025-11-03: 처음 풂, row_number, rank, dense_rank의 차이점 헷갈림
-- 2025-11-04: 가장 높은 salary를 가진 job title을 찾는 문제이기 때문에, 각 직무별로 partition by 하면 안 됨