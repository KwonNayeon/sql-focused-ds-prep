-- 처음 쿼리
WITH cte1 AS (
    SELECT
        user_id,
        MIN(DATE(created_at)) AS first_purchase_date
    FROM marketing_campaign
    GROUP BY user_id
),
cte2 AS (
    -- 첫날 구매 제품
    SELECT
        m.user_id,
        m.product_id
    FROM marketing_campaign m
    JOIN cte1 a ON m.user_id = a.user_id
    AND DATE(m.created_at) = a.first_purchase_date
),
cte3 AS (
    -- 이후 구매 제품
    SELECT DISTINCT
        m.user_id,
        m.product_id
    FROM marketing_campaign m
    JOIN cte1 a ON m.user_id = a.user_id
    AND DATE(m.created_at) > a.first_purchase_date
)
SELECT COUNT(DISTINCT user_id) AS campaign_success_users
FROM (
    SELECT user_id, product_id FROM cte3
    EXCEPT  -- 첫날 제품 제외
    SELECT user_id, product_id FROM cte2
) new_products
;

-- 개선된 쿼리
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

-- Review Notes:
-- 2025-12-15: 복습하기
