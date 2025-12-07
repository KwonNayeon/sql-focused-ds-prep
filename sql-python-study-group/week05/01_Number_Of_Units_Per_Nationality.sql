-- Number Of Units Per Nationality
-- Apartment만 필터링 해야함

select
    h.nationality,
    count(distinct u.unit_id) as n_unit
from airbnb_hosts h
join airbnb_units u on h.host_id = u.host_id
where h.age < 30
    and u.unit_type = 'Apartment'
group by h.nationality
order by n_unit desc
;
