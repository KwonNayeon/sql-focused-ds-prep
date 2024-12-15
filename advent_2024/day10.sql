with max AS(
  select max(x) as max_x, max(y) as max_y
  from points
)
select id
from points, max
where points.x = max.max_x or points.y = max.max_y
order by x asc, y asc
