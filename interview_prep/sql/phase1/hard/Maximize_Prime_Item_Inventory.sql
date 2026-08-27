with summary as (
  SELECT
    item_type,
    sum(square_footage) as total_sqft,
    count(item_id) as item_count
  FROM inventory
  group by item_type
),
prime_occupied_area as (
  select
    item_type,
    total_sqft,
    floor(500000/total_sqft) as prime_item_batch_count,
    floor((500000/total_sqft) * item_count) as prime_item_count
  from summary
  where item_type = 'prime_eligible'
)
select
  item_type,
  case when item_type = 'prime_eligible' then (floor(500000/total_sqft) * item_count)
    when item_type = 'not_prime' then floor((500000 - (SELECT FLOOR(500000/total_sqft) * total_sqft from prime_occupied_area)) / total_sqft) * item_count
  end as item_count
from summary
order by item_type desc
;

-- Review Notes:
-- 2026-08-27: 내일 복습하기
