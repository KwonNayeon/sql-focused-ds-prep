-- Find the genre of the person with the most number of oscar winnings

with cte as (
    select
        o.nominee,
        n.top_genre,
        count(*) as n_winnings
    from oscar_nominees o
    join nominee_information n on o.nominee = n.name
    where o.winner = 'TRUE'
    group by o.nominee, n.top_genre     -- 사람별로 그룹화
)
select
    top_genre
from cte
order by n_winnings desc, nominee asc   -- 동점 시 이름 알파벳 순서로 정렬
limit 1
;
