-- 가장 많은 총 신고를 받은 비디오 찾기
with total_flags as (
    select
        video_id,
        count(flag_id) as total_flag_count
    from user_flags
    where video_id is not null
    and flag_id is not null
    group by video_id
),
max_flags as (
    select video_id
    from total_flags
    where total_flag_count = (select (max(total_flag_count)) from total_flags)

)
-- 해당 비디오들의 검토된 신고만 카운트
select
    uf.video_id,
    count(uf.flag_id) as cnt_flag
from user_flags uf
inner join flag_review fr on uf.flag_id = fr.flag_id
where fr.reviewed_by_yt = 'TRUE'
and uf.video_id in (select video_id from max_flags)
group by uf.video_id
;
-- Review Notes:
-- 2025-12-16: 복습하기
