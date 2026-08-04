with cte as (
  SELECT
    category,
    product,
    sum(spend) as total_spend
  FROM product_spend
  where extract(year from transaction_date) = 2022
  group by category, product
),
cte2 as (
  select
    *,
    rank() over (partition by category order by total_spend desc) as rk
  from cte
)
select
  category,
  product,
  total_spend
from cte2
where rk in (1, 2)
;
