-- 'spam' 문자열이 keywords에 있는지 확인하는 문제
with cte as (
    select
        post_date,
        case when p.post_keywords ilike '%spam%' then 'spam' else 'ham' end as is_spam
    from facebook_post_views v
    join facebook_posts p
    on v.post_id = p.post_id
)
select
    post_date,
    (sum(case when is_spam = 'spam' then 1 else 0 end)::float / count(*)) * 100 as spam_ratio
from cte
group by post_date
;
