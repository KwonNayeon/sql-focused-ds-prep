select B.name
from games A
left join companies B
on A.publisher_id = B.company_id
group by B.name
having count(game_id) > 9
order by B.name asc
;
