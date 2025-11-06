select
    city,
    property_type,
    avg(bathrooms) as n_avg_bathrooms,
    avg(bedrooms) as n_avg_bedrooms
from airbnb_search_details
group by city, property_type

-- Review Notes:
-- 2025-11-06: 윈도우 함수 + DISTINCT보다 GROUP BY가 더 효율적
