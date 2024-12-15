select
  game_id,
  name,
  year
from
  games
WHERE
  name like '%Santa%'
  or name like '%Christmas%';
