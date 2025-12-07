-- Actor Rating Difference Analysis

with latest as (
    select
        actor_name,
        film_rating as latest_rating,
        release_date as latest_release_date
    from (select actor_name,
                film_rating,
                release_date,
                row_number() over (partition by actor_name order by release_date desc) as rn
        from actor_rating_shift)
    where rn = 1
),
avg as (
    select
        a.actor_name,
        avg(a.film_rating) as avg_rating
    from actor_rating_shift a
    join latest l on a.actor_name = l.actor_name
    where a.release_date < l.latest_release_date    -- 최신 영화 제외
    group by a.actor_name
)
SELECT
    l.actor_name,
    COALESCE(a.avg_rating, l.latest_rating) AS avg_rating,
    l.latest_rating,
    ROUND(COALESCE(l.latest_rating - a.avg_rating, 0)::NUMERIC, 2) AS rating_difference
FROM latest l
LEFT JOIN avg a ON l.actor_name = a.actor_name  -- LEFT JOIN으로 영화 1개인 배우도 포함
;
