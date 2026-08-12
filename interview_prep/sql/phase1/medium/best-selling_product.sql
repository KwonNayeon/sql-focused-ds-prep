with cte as (
  SELECT
    a.category_name,
    a.product_name,
    rank() over (partition by a.category_name order by b.sales_quantity desc, b.rating desc) as rk
  FROM products a
  join product_sales b
  on a.product_id = b.product_id
)
select
  category_name,
  product_name
from cte
where rk=1
;
