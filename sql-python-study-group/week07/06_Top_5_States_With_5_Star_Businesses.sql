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
