WITH cte AS (
  SELECT
    city_id,
    customer_id,
    SUM(total_price - discount_amount) AS total_spent
  FROM transactions
  WHERE is_returned = 0
  GROUP BY city_id, customer_id
),
cte2 AS (
  SELECT
    city_id,
    customer_id,
    total_spent,
    ROW_NUMBER() OVER (PARTITION BY city_id ORDER BY total_spent DESC) AS rk
  FROM cte
)
SELECT
  city_id,
  customer_id,
  total_spent
FROM cte2
WHERE rk = 1
ORDER BY city_id
;
