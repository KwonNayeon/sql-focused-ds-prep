select
    count(case when country = 'USA' and status = 'open' then 1 end) * 1.0 / count(*) * 1.0 * 100 as ratio
from fb_active_users
;
