-- Player with Longest Streak
/*
문제: 연속된 Win 구간 찾기 (Loss가 나오면 구간 끊김)
해결: Loss를 "구간 구분자"로 사용
- Loss 만날 때마다 그룹 번호 증가
- 연속된 Win은 같은 그룹 번호 공유
- 같은 그룹끼리 묶어서 개수 세기
*/
with loss_counter as (
    select
        player_id,
        match_date,
        match_result,
        sum(case when match_result = 'L' then 1 else 0 end) over (partition by player_id order by match_date) as loss_group
    from players_results
),
win_streaks as (
    select 
        player_id,
        loss_group,
        count(*) as streak_length
    from loss_counter
    where match_result = 'W'
    group by player_id, loss_group
    order by streak_length desc
)
select
    player_id,
    streak_length
from win_streaks
where streak_length = (select max(streak_length) from win_streaks)
;
-- Review Notes:
-- 2025-11-30: 풀이를 봐도 이해가 잘 안 됨. 복습하기
