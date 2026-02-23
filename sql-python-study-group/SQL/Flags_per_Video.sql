-- 이름 파생변수 만드는 법 복습
with cte as (
    SELECT
        COALESCE(user_firstname, '') || ' ' || COALESCE(user_lastname, '') AS full_name,
        video_id,
        flag_id
    FROM user_flags
    where flag_id is not null
)
select
    video_id,
    count(distinct full_name) as num_unique_users
from cte
group by video_id
;
