with data as (
  select
    case when device_type in ('laptop') then 1 else 0 end as laptop_views,
    case when device_type in ('phone', 'tablet') then 1 else 0 end as mobile_views
  from viewership
)
select
  sum(laptop_views) as laptop_views,
  sum(mobile_views) as mobile_views
from data