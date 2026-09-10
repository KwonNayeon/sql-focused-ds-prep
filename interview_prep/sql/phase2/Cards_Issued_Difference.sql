-- 풀이 1
with data as(
  select
    card_name,
    max(issued_amount) as max,
    min(issued_amount) as min
  from monthly_cards_issued
  group by card_name
)
select
  card_name,
  max - min as difference
from data
order by difference desc
;

-- 풀이 2
SELECT
  card_name,
  max(issued_amount) - min(issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by difference desc
;
