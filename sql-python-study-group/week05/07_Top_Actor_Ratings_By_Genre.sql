-- Top Actor Ratings by Genre
/*
놓친 부분:

1. 문제 이해: 배우별 top 3 vs 전체 top 3
   내가 한 것: PARTITION BY actor_name으로 각 배우별 top 3 구함
   문제에서 원하는 것: 전체에서 avg_rating 기준 top 3 rank만 (배우 간 비교)
   → "Rank all resulting actor + genre pairs" = 전체 랭킹

2. 랭킹 단계 관련
   - 1단계: 배우별로 most frequent genre 찾기 (PARTITION BY actor_name)
   - 2단계: 그 결과들을 전체 비교해서 랭킹 (PARTITION BY 없이)
   → 두 번의 랭킹 필요

3. WHERE 조건
   - genre_rank = 1: 배우별 필터링 (actor_top_genre에서)
   - overall_rank <= 3: 전체 필터링 (final_rank에서)
   → 각 랭킹마다 별도 필터링 단계 필요
*/

WITH movie_rating AS (
    SELECT
        actor_name,
        genre,
        AVG(movie_rating) AS avg_rating,
        COUNT(genre) AS cnt
    FROM top_actors_rating
    GROUP BY actor_name, genre
),
actor_top_genre AS (
    SELECT
        actor_name,
        genre,
        avg_rating,
        cnt,
        DENSE_RANK() OVER (PARTITION BY actor_name ORDER BY cnt DESC, avg_rating DESC) AS genre_rank
    FROM movie_rating
),
top_genres AS (
    SELECT
        actor_name,
        genre,
        avg_rating
    FROM actor_top_genre
    WHERE genre_rank = 1  -- 각 배우별 most frequent genre
),
final_rank AS (
    SELECT
        actor_name,
        genre,
        avg_rating,
        DENSE_RANK() OVER (ORDER BY avg_rating DESC) AS overall_rank
    FROM top_genres
)
SELECT
    actor_name,
    genre,
    avg_rating,
    overall_rank
FROM final_rank
WHERE overall_rank <= 3
ORDER BY overall_rank, actor_name
;

-- Review Notes:
-- 2025-12-07: 꼭 다시 보기
-- 2025-12-09: 리뷰 완료. 그런데 혼자 풀 자신 없음
