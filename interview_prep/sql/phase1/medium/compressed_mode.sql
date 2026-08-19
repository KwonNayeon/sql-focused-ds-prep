-- 풀이 1
with max as (
  SELECT
    max(order_occurrences) as max
  from items_per_order
)
select
  item_count as mode
from items_per_order
where order_occurrences = (select max(order_occurrences) as max from items_per_order)

-- 풀이 2
with cte as (
  SELECT
    *,
    rank() over (order by order_occurrences desc) as rk
  FROM items_per_order
)
select
  item_count as mode
from cte 
where rk = 1
order by mode asc
;
