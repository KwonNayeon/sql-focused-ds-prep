-- Host Popularity Rental Prices
-- 각 검색 결과 레코드를 popularity 기준으로 집계 (중복 제거 불필요)
with cte as (
    select
        *,
        case when number_of_reviews = 0 then 'New'
             when number_of_reviews <= 5 then 'Rising'
             when number_of_reviews <= 15 then 'Trending Up'
             when number_of_reviews <= 40 then 'Popular'
             else 'Hot' end as host_popularity
    from airbnb_host_searches
)
select
    host_popularity,
    min(price) as minimum,
    avg(price) as average,
    max(price) as maximum
from cte
group by host_popularity
;
