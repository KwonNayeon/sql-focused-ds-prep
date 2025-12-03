WITH customer AS (
    SELECT
      r.customer_id,
      r.sales
    FROM records r
    LEFT JOIN customer_stats c ON r.customer_id = c.customer_id
    WHERE r.order_date LIKE '2020-12%'
)
SELECT
  customer_id
FROM customer
group by customer_id
having sum(sales) >= 1000
;
