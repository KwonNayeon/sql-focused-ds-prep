-- 월(month)별로만 집계
select 
  extract(month from submit_date) as mth,
  product_id as product,
  round(avg(stars), 2) as avg_stars
from reviews
group by mth, product
order by mth, product
;