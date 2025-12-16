-- 같은 주문에 여러 카테고리 상품이 있을 수 있으므로, order_id를 기준으로 중복을 제거해야 함
with cte as (
  select
    r.category,
    r.sub_category,
    cs.first_order_date,
    r.order_id
  from records r 
  left join customer_stats cs on r.customer_id = cs.customer_id
  where r.order_date = cs.first_order_date
)
select
  category,
  sub_category,
  count(distinct order_id) as cnt_orders
from cte 
group by category, sub_category
order by cnt_orders desc
;
