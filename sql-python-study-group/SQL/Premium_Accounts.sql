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
    d.entry_date,
    d.premium_paid_accounts,
    s.premium_paid_accounts_after_7d
from daily d
left join seven_days_later s
    on d.entry_date = s.entry_date
order by d.entry_date
limit 7
;
