with ranked as (
  SELECT
    date_trunc('day', measurement_time) as measurement_day,
    measurement_value,
    row_number() over (partition by date_trunc('day', measurement_time) order by measurement_time) as rn
  FROM measurements
)
select
  measurement_day,
  sum(case when rn%2 = 1 then measurement_value end) as odd_sum,
  sum(case when rn%2 = 0 then measurement_value end) as even_sum
from ranked
group by measurement_day
;
