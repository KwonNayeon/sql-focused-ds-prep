-- Popularity Percentage
with users as (
    select user1, user2 from facebook_friends
    union
    select user2 as user1, user1 as user2 from facebook_friends
)
select
    user1,
    count(*)::float / (select count(distinct user1) from users) * 100 as popularity_percent
from users
group by user1
order by user1
;

/*
facebook_friends:
user1  user2
1      2
2      3

-- UNION으로 방향 뒤집기
SELECT user1, user2 FROM facebook_friends  -- 1→2, 2→3
UNION
SELECT user2, user1 FROM facebook_friends  -- 2→1, 3→2

결과:
user1  user2
1      2
2      1
2      3
3      2
*/

-- union: 중복 제거, union all: 중복 포함
-- count(distinct user1)은 GROUP BY 안에서 계산돼서 항상 1, 전체 유저 수가 필요하면 서브쿼리를 사용해야 함
with users as (
    select
        user1, user2
    from facebook_friends
    
    union
    
    select user2 as user1, user1 as user2
    from facebook_friends
)
select
    user1,
    count(*) * 1.0 / (select count(distinct user1) from users) * 100 as popularity_percent
from users
group by user1
;

-- Review Notes:
-- 2026-02-10: 복습 완료
