with rank as (
    select
        business_id,
        name,
        review_count,
        row_number() over (order by review_count desc) as review_rn
    from yelp_business
)
select
    name,
    review_count
from rank
where review_rn < 6
;
