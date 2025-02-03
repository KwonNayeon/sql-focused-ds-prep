with max as (
  SELECT
    max(order_occurrences) as max
  from items_per_order
)
select
  item_count as mode
from items_per_order
where order_occurrences = (select max(order_occurrences) as max from items_per_order)
