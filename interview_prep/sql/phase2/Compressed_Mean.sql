-- 풀이 1
-- 정수 나눗셈을 방지하기 위해서 ::numeric 사용해야 함
with data as (
  SELECT
    sum(item_count * order_occurrences) as total_items,
    sum(order_occurrences) as total_orders
  FROM items_per_order
)
select 
  round(total_items::numeric / total_orders, 1) as mean
from data
;

-- 풀이 2
-- 정수 나눗셈을 방지하기 위해서 분자를 미리 소수로 변환
select
  round(sum(item_count::DECIMAL*order_occurrences) / sum(order_occurrences), 1) as mean
from items_per_order
;
