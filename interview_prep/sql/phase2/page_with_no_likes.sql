select p.page_id
from pages p 
left join page_likes pl on p.page_id = pl.page_id
where pl.liked_date is null
order by p.page_id