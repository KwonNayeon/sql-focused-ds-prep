-- Largest Olympics
select
    games,
    count(distinct id) as cnt
from olympics_athletes_events
group by games
order by cnt desc
limit 1
;
