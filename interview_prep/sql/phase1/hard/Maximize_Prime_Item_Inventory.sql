with prime_batch as (
  select
    sum(square_footage) as batch_sqft,
    count(item_id) as items_per_batch
  from inventory
  where item_type = 'prime_eligible'
),
nonprime_batch as (
  select
    sum(square_footage) as batch_sqft,
    count(item_id) as items_per_batch
  from inventory
  where item_type = 'not_prime'
),
calc as (
  select
    p.batch_sqft as prime_sqft,
    p.items_per_batch as prime_items,
    n.batch_sqft as nonprime_sqft,
    n.items_per_batch as nonprime_items,
    -- non-prime 배치 1개 자리는 미리 빼놓고 prime 배치 수를 최대화
    floor((500000 - n.batch_sqft) / p.batch_sqft) as prime_batch_count
  from prime_batch p, nonprime_batch n
)
select 'prime_eligible' as item_type,
       prime_batch_count * prime_items as item_count
from calc

union all

select 'not_prime' as item_type,
       floor((500000 - prime_batch_count * prime_sqft) / nonprime_sqft) * nonprime_items as item_count
from calc

order by item_type desc;

-- Review Notes:
-- 2026-08-27: 내일 복습하기
-- 2026-08-28: 풀이는 어느정도 이해 되는데, 혼자 풀기는 어려울듯
-- 2026-09-01: 쿼리 직접 짜봄, 마지막에 prime_batch_count * prime_sqft (개수*면적) 실수만 조심하기
