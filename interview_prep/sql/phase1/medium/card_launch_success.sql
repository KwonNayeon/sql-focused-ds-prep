with cte as (
  SELECT
    card_name,
    issued_amount,
    row_number() over (partition by card_name order by issue_year asc, issue_month asc) as rn
  FROM monthly_cards_issued
)
select
  card_name,
  issued_amount
from cte
where rn = 1
order by issued_amount desc
;
