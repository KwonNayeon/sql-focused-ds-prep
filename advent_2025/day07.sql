with cte as (
  select
    measured_at,
    pm10,
    lag(pm10) over (order by measured_at) as previous_day,
    lead(pm10) over (order by measured_at) as next_day
  from measurements
)
select
  measured_at + interval 1 day as date_alert
from cte
where previous_day < pm10
and pm10 < next_day
and next_day >= 30
;
