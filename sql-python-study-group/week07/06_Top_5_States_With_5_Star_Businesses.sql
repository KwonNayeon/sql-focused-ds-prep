-- Top 5 States With 5 Star Businesses
with cnt as (
    select
        state,
        count(case when stars = 5 then 1 end) as five_stars
    from yelp_business
    group by state
),
ranked as (
    select
        state,
        five_stars,
        dense_rank() over (order by five_stars desc) as rk
    from cnt
)
select
    state,
    five_stars
from ranked
where rk <= 5
;

with count as (
    select
        state,
        count(business_id) as n_businesses
    from yelp_business
    where stars = 5
    group by state
),
rank as (
    select
        state,
        n_businesses,
        dense_rank() over (order by n_businesses desc) rank
    from count
)
select
    state,
    n_businesses
from rank
where rank <= 5

-- Review Notes:
-- 2026-02-09: 복습 완료
