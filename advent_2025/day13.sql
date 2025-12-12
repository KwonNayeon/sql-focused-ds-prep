-- 나중에 복습하기
-- LEFT JOIN → JOIN: 배우/영화 정보가 필요하기 때문에 INNER JOIN 사용
-- GROUP BY에 actor_id 추가: 동명이인 배우 구분
SELECT
  a.first_name,
  a.last_name,
  SUM(film_revenue.revenue) as total_revenue
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN (
  SELECT 
    f.film_id,
    SUM(p.amount) as revenue
  FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY f.film_id
) film_revenue ON fa.film_id = film_revenue.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_revenue DESC
LIMIT 5;
