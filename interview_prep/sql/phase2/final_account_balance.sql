-- 풀이 1
-- CASE문으로 Deposit은 +, Withdrawal은 -로 변환 후 SUM
SELECT
  account_id,
  sum(case
    when transaction_type = 'Deposit' then amount
    when transaction_type = 'Withdrawal' then -amount
  END) as final_balance
from transactions
group by account_id
;

-- 풀이 2
with cte as (
  SELECT
    account_id,
    sum(case when transaction_type = 'Deposit' then amount else 0 end) as deposit,
    sum(case when transaction_type = 'Withdrawal' then amount else 0 end) as withdrawal
  FROM transactions
  group by account_id
)
select
  account_id,
  (deposit - withdrawal) as final_balance
from cte
;
