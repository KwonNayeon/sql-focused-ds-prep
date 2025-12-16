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
-- Review Notes:
-- 2025-12-15: 복습하기
