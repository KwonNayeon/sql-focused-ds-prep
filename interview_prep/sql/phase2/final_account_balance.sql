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