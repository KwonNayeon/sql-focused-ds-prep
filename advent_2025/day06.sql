select distinct r.customer_id
from rental r 
left join customer c on r.customer_id = c.customer_id
where active = 1
group by r.customer_id
having count(r.rental_id) >= 35
;
