-- Apple Product Counts

select
    u.language,
    count(distinct case when device in ('macbook pro', 'iphone 5s', 'ipad air') then e.user_id end) as n_apple_users,
    count(distinct e.user_id) as n_total_users
from playbook_events e
left join playbook_users u on e.user_id = u.user_id
group by u.language
;
