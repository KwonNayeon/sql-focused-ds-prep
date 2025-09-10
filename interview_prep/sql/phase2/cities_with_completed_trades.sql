select u.city, count(*)
from trades t 
join users u on t.user_id = u.user_id
where status = 'Completed'
group by u.city
order by count(*) desc
limit 3
;