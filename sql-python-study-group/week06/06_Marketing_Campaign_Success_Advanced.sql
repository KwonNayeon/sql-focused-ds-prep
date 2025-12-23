-- 1. dense rank는 같은 날짜에 여러 개 구매했을 경우 같은 순위로 처리하는 것을 이용
-- 2. 같은 제품을 다시 구매할 경우, product_rn이 2가 됨
with cte as (
    select
        user_id, created_at, product_id,
        dense_rank() over (partition by user_id order by created_at) as data_rn,
        dense_rank() over (partition by user_id, product_id order by created_at) as product_rn
    from marketing_campaign
)
select count(distinct user_id) as user_cnt
from cte
where data_rn > 1 and product_rn = 1
;
