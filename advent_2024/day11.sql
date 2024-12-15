with
  weekday as (
    select
      *,
      case strftime ('%w', measured_at)
        when '1' then '월요일'
        when '2' then '화요일'
        when '3' then '수요일'
        when '4' then '목요일'
        when '5' then '금요일'
        when '6' then '토요일'
        when '0' then '일요일'
      end as weekday
    from
      measurements
  )
select
  weekday,
  round(avg(no2), 4) as no2,
  round(avg(o3), 4) as o3,
  round(avg(co), 4) as co,
  round(avg(so2), 4) as so2,
  round(avg(pm10), 4) as pm10,
  round(avg(pm2_5), 4) as pm2_5
from
  weekday
group by
  weekday
order BY
  case weekday
    when '월요일' then 1
    when '화요일' then 2
    when '수요일' then 3
    when '목요일' then 4
    when '금요일' then 5
    when '토요일' then 6
    when '일요일' then 7 end
;
