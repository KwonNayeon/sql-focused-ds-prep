-- MySQL
select
  measured_at as good_day
from measurements
where pm2_5 <= 9
and measured_at like '2022-12%'
order by measured_at ASC
;
