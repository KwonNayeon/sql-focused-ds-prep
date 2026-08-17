select
  COALESCE(a.user_id, b.user_id) as user_id,
  COALESCE(a.song_id, b.song_id) as song_id,
  COALESCE(a.song_plays, 0) + count(b.listen_time) as song_plays
from songs_history a 
full join songs_weekly b
on a.user_id = b.user_id and a.song_id = b.song_id
where date(b.listen_time) <= '2022-08-04' or b.listen_time is null
group by COALESCE(a.user_id, b.user_id), COALESCE(a.song_id, b.song_id), a.song_plays
order by song_plays desc
;

-- Review Notes:
-- 2026-08-14: join 조건, null값 처리가 까다로운 문제 (한 테이블에만 존재하는 데이터 처리 때문), 복습하기
-- 2026-08-17: where 절에 listen time이 null인 경우를 꼭 처리해줘야 함
