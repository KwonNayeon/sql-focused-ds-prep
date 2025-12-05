-- Rank Variance Per Country

with monthly_comments as (
    select
        u.country,
        sum(case when c.created_at >= '2019-12-01' and c.created_at < '2020-01-01' then c.number_of_comments else 0 end) as dec_comments,
        sum(case when c.created_at >= '2020-01-01' and c.created_at < '2020-02-01' then c.number_of_comments else 0 end) as jan_comments
    from fb_comments_count c
    join fb_active_users u on c.user_id = u.user_id
    group by u.country
),
ranked as (
    select
        country,
        dense_rank() over (order by dec_comments desc) as dec_rank,
        dense_rank() over (order by jan_comments desc) as jan_rank
    from monthly_comments
)
select country
from ranked
where dec_rank > jan_rank
;
