with cte as (
  select
    user_a_id,
    user_b_id,
    (user_a_id+user_b_id) as id_sum,
    percent_rank() over (order by (user_a_id+user_b_id)) as percentile
  from edges
)
select
  user_a_id,
  user_b_id,
  id_sum
from cte
where percentile <= 0.001
order by id_sum
;
