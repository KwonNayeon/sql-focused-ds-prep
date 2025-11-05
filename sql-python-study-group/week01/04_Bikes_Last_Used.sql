select
    bike_number,
    max(end_time) as last_used
from dc_bikeshare_q1_2012
group by bike_number
order by max(end_time) desc
;

-- Review Notes:
-- 2025-11-05: 처음 풂, 쉬운 문제
