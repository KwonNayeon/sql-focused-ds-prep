-- Find all Lyft drivers who earn either equal to or less than 30k USD
-- or equal to or more than 70k USD.
select
    *
from lyft_drivers
where yearly_salary <= 30000
    or yearly_salary >= 70000
;

-- Review Notes:
-- 2025-11-12: 쉬운 문제
