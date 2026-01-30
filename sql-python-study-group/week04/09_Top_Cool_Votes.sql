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
