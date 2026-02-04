-- Top 10 Songs 2010
with cte as (
    select
        dense_rank() over (order by year_rank asc) as rank,
        group_name,
        song_name
    from billboard_top_100_year_end
    where year = 2010
)
select
    distinct rank,
    group_name,
    song_name
from cte
where rank < 11
order by rank
;
