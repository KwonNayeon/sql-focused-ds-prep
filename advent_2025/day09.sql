with merged as (
  SELECT
    a.id,
    a.name,
    g.year,
    lag(g.year) over (partition by a.id order by g.year asc) as previous_year
  from athletes a
  join records r on a.id = r.athlete_id
  join events e on e.id = r.event_id
  join teams t on r.team_id = t.id
  join games g on g.id = r.game_id
  where e.event = 'Volleyball Women''s Volleyball'
  and t.team = 'KOR'
  and g.year is not null
)
select
  distinct id,
  name
from merged
where (year - previous_year) = 4
;
