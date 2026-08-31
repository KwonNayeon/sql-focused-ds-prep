select
  a.page_id
from pages a 
left join page_likes b
on a.page_id = b.page_id
where b.page_id is null
order by a.page_id
;

-- Review Notes:
-- 2026-08-31: 복습완료
