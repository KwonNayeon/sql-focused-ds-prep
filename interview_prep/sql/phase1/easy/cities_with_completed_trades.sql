SELECT
  u.city,
  count(t.order_id) as total_orders
FROM trades t
join users u
on t.user_id = u.user_id
where t.status = 'Completed'
group by u.city
order by count(t.order_id) desc
limit 3
;
