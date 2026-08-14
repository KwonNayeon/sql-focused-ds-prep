with ranked as (
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
from ranked
where rk=1
;

-- Review Notes:
-- 2026-08-14: 복습하기
