select
  title
from
  film
WHERE
  rating in ('R', 'NC-17')
AND
  substr(title, -1) not in ('A', 'E', 'I', 'O', 'U');
