SELECT
  extract(month from submit_date) as month,
  product_id,
  round(avg(stars), 2) as avg_star
FROM reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id
;
