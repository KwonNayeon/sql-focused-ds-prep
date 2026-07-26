-- Top Cool Votes
with cte as (
    select
        business_name,
        review_text,
        dense_rank() over (order by cool desc) as rk
    from yelp_reviews
)
select
    business_name,
    review_text
from cte
where rk = 1
;

-- Review Notes:
-- 2026-07-26: 복습, rank() or dense_rank() 사용하면 됨
