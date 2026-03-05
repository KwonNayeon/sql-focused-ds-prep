with daily as (
    select
        entry_date,
        count(account_id) as premium_paid_accounts
    from premium_accounts_by_day
    where final_price != 0
    group by entry_date
),
seven_days_later as (
    select
        a.entry_date,
        count(b.account_id) as premium_paid_accounts_after_7d
    from premium_accounts_by_day a
    join premium_accounts_by_day b
        on a.account_id = b.account_id
        and b.entry_date = a.entry_date + 7
        and b.final_price != 0
    where a.final_price != 0
    group by a.entry_date
)
select
    a.entry_date,
    a.premium_paid_accounts,
    b.premium_paid_accounts_after_7d
from daily a
join seven_days_later b on a.entry_date = b.entry_date
order by a.entry_date
limit 7;
