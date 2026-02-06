-- Find Students At Median Writing
-- PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
with cte as (
    select
        percentile_cont(0.5) within group (order by sat_writing) as median_writing
    from sat_scores
)
select student_id
from sat_scores s
join cte c
on s.sat_writing = c.median_writing
;

-- Review Notes:
-- 2026-02-06: 함수만 잘 기억해두면 됨

