-- Tie가 없는 경우
SELECT
  drug,
  sum(total_sales - cogs) as total_profit
from pharmacy_sales
group by drug
order by sum(total_sales - cogs) desc
limit 3;

-- Tie가 있는 경우
-- RANK() 사용 필요
   WITH ranked AS (
     SELECT
       drug,
       sum(total_sales - cogs) as total_profit,
       RANK() OVER (ORDER BY sum(total_sales - cogs) DESC) as rnk
     FROM pharmacy_sales
     GROUP BY drug
   )
   SELECT drug, total_profit
   FROM ranked
   WHERE rnk <= 3;