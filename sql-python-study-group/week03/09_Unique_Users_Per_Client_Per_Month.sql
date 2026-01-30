-- user_id의 수를 세야 함
with data as (
    select
        *,
        extract(month from time_id) as month
    from fact_events
)
select
    client_id,
    month,
    count(distinct user_id) as n_user
from data
group by client_id, month
order by client_id, month
;
