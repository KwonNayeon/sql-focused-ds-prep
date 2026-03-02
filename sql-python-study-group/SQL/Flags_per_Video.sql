with fullname as (
    select
        coalesce(user_firstname, '') || ' ' || coalesce(user_lastname, '') as user_fullname,
        video_id,
        flag_id
    from user_flags
    where flag_id is not null
)
select
    video_id,
    count(distinct user_fullname) as num_unique_users
from fullname
group by video_id
;
