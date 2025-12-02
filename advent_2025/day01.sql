-- MySQL
select
  title,
  year,
  rotten_tomatoes
from
  movies
where
  lower(title) like '%love%'
order by
  rotten_tomatoes desc,
  year desc
;
