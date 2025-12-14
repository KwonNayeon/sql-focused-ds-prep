select
  c.name as artist,
  a.title
from artworks a
join artworks_artists b on a.artwork_id = b.artwork_id
join artists c on b.artist_id = c.artist_id
where a.classification like 'Film%'
and c.nationality = 'Korean'
;
