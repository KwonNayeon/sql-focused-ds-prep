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
-- 2026-08-18: sales quantity, rating으로 order by를 했을 때, tie가 나오지 않는다고 가정, 그래서 rank(), row_number() 둘 중 뭘 써도 괜찮다고 생각함
