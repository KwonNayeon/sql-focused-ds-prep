-- Processed Ticket Rate By Type
select
    type,
    round(count(case when processed='TRUE' then 1 end)*1.0 / count(*), 2) as rate
from facebook_complaints
group by type
;

-- Review Notes:
-- 2026-02-08: 복습 완료
