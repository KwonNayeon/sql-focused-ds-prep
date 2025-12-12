-- LEFT JOIN → JOIN: 배우/영화 정보가 필요하기 때문에 INNER JOIN 사용
-- GROUP BY에 actor_id 추가: 동명이인 배우 구분
select
  a.first_name,
  a.last_name,
  sum(film_revenue.revenue) as total_revenue
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join (
  select
    f.film_id,
    sum(p.amount) as revenue
  from film f
  join inventory i on f.film_id = i.film_id
  join rental r on i.inventory_id = r.inventory_id
  join payment p on r.rental_id = p.rental_id
  group by f.film_id
) film_revenue on fa.film_id = film_revenue.film_id
group by a.actor_id, a.first_name, a.last_name
order by total_revenue desc
limit 5
;
