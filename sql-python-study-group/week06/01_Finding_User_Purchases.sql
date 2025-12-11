with orders as (
    select
        user_id,
        created_at,
        lag(created_at) over (partition by user_id order by created_at asc) as previous_order,
        -- 첫 번째, 두 번째 구매 사이의 간격을 확인하기 위함
        row_number() over (partition by user_id order by created_at asc) as order_number
    from amazon_transactions
)
select
    distinct user_id
from orders
where (created_at-previous_order) between 1 and 7
and order_number = 2
;
