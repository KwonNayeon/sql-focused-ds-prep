with cte as (
  SELECT
    policy_holder_id,
    count(case_id) as cnt
  FROM callers
  group by policy_holder_id
  having count(case_id) > 2
)
select
  count(policy_holder_id) as policy_holder_count
from cte
;