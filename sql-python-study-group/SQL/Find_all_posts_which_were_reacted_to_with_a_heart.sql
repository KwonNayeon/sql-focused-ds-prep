-- 한 게시글에 heart가 2개여도 결과는 한 번만 출력되어야 하므로 distinct 필요
select
    distinct p.*
from facebook_posts p
join facebook_reactions r
on p.post_id = r.post_id
where r.reaction = 'heart'
;
