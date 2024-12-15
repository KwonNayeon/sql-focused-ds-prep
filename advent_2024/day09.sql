-- 주요 기능:
-- 1. gamegenre CTE:
--    - 장르별 평균 평점 및 평점 수 계산
--    - critic_score: 소수점 3자리 반올림 (round(avg(critic_score), 3))
--    - critic_count와 user_count: 올림(CEIL) 처리로 소수점 제거
--    - user_score: 소수점 3자리 반올림 (round(avg(user_score), 3))

-- 2. 데이터 결합:
--    - games 테이블과 gamegenre CTE를 장르 ID(genre_id)를 기준으로 JOIN
--    - COALESCE 함수로 누락된 값(critic_score, critic_count, user_score, user_count)을 장르별 평균 값으로 대체

-- 3. 필터링:
--    - 출시 연도(year) > 2014 조건 추가 (2015년 이후 출시된 게임)
--    - 누락된 평점 데이터(critic_score, critic_count, user_score, user_count) 있는 경우만 선택

with gamegenre AS(
  SELECT
    genre_id,
    round(avg(critic_score), 3) as critic_score,
    CEIL(avg(critic_count)) as critic_count,
    round(avg(user_score), 3) as user_score,
    CEIL(avg(user_count)) as user_count
  from games
  group by genre_id
)
select A.game_id, A.name,
COALESCE(A.critic_score, B.critic_score) as critic_score,
COALESCE(A.critic_count, B.critic_count) as critic_count,
COALESCE(A.user_score, B.user_score) as user_score,
COALESCE(A.user_count, B.user_count) as user_count
from games A
join gamegenre B
on A.genre_id = B.genre_id
where year > 2014
and (A.critic_score is null or A.critic_count is null or A.user_count is null or A.user_score is null)
