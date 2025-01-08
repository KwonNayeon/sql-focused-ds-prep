-- ============================================================
-- [트러블슈팅 노트] Global Top 5 Artists
-- Filename: global_top_5_artists.sql
-- 
-- [1] 목표:
--   - global_song_rank 테이블의 rank가 10 이하인 노래를 가진 아티스트 추출
--   - 해당 노래 수를 기준으로 아티스트의 순위 산출
--   - 상위 5위까지의 아티스트 정보 출력
--
-- [2] 문제 상황과 해결 과정:
--   1. 초기 접근의 어려움:
--      - 여러 테이블을 JOIN하는 순서 결정
--      - 중간 집계 결과를 어떻게 처리할지 고민
--      - 윈도우 함수와 GROUP BY의 사용 시점 결정
--      
--   2. 복잡한 방식에서 간단한 방식으로 개선:
--      - 다단계 CTE 사용에서 단일 CTE로 변경
--      - 순차적 JOIN에서 다중 테이블 한번에 JOIN으로 변경
--      - 중간 집계 단계 제거하고 직접적인 COUNT 사용
--
-- [3] 학습 포인트:
--   - SQL 최적화의 중요성:
--     * 불필요한 중간 단계 제거
--     * 한번의 GROUP BY로 집계 처리
--   - JOIN 전략:
--     * 여러 단계의 JOIN vs 한번에 처리
--     * 필요한 데이터만 효율적으로 JOIN
--   - 윈도우 함수의 활용:
--     * DENSE_RANK의 적절한 사용 시점
--     * COUNT와 GROUP BY의 조합
-- ============================================================

-- [초기 접근]
with data1 as (
  select A.artist_id, A.artist_name, B.song_id
  from artists A
  join songs B
  on A.artist_id = B.artist_id
),
data2 as (
  select A.artist_name, B.rank
  from data1 A
  join global_song_rank B
  on A.song_id = B.song_id
  where B.rank <= 10    -- rank 10 이하 필터링을 여기서 해주고
),
data3 as (
  select 
    artist_name,
    count(*) as song_count   -- 각 아티스트별 top 10에 든 노래 수를 세고
  from data2
  group by artist_name
),
data4 as (
  select 
    artist_name,
    DENSE_RANK() over (order by song_count desc) as artist_rank  -- 그 노래 수로 순위를 매김
  from data3
)
select artist_name, artist_rank
from data4
where artist_rank <= 5;

-- [모범 답안]
WITH top_10_cte AS (
  SELECT 
    artists.artist_name,
    DENSE_RANK() OVER (
      ORDER BY COUNT(songs.song_id) DESC
    ) AS artist_rank
  FROM artists
  INNER JOIN songs 
    ON artists.artist_id = songs.artist_id
  INNER JOIN global_song_rank AS ranking
    ON songs.song_id = ranking.song_id
  WHERE ranking.rank <= 10
  GROUP BY artists.artist_name
)
SELECT artist_name, artist_rank
FROM top_10_cte
WHERE artist_rank <= 5;
