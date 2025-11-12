-- step 1: merge
-- step 2: find the average popularity of the Hack per office location
select
    fe.location,
    avg(fh.popularity)
from facebook_employees fe
join facebook_hack_survey fh on fe.id = fh.employee_id
group by fe.location
;

-- Review Notes:
-- 2025-11-12: 쉬운 문제
