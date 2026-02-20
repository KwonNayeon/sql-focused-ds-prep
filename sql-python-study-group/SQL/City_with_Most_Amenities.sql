with cnt as (
    SELECT
        city,
        amenities,
        -- 원본 길이 - 쉼표 제거 길이 = 쉼표 개수 → +1 
        LENGTH(amenities) - LENGTH(REPLACE(amenities, ',', '')) + 1 as n_amenities
    FROM airbnb_search_details
),
rank as (
    select
        city,
        dense_rank() over (order by n_amenities desc) as rank
    from cnt
)
select city
from rank
where rank = 1
;
