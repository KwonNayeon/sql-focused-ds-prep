select
    extract(year from inspection_date) as inspection_year,
    count(violation_id) as n_violations
from sf_restaurant_health_violations
where violation_id is not null
    and business_name = 'Roxanne Cafe'
group by extract(year from inspection_date)
;