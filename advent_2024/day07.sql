select round(cast(count(case when credit like '%gift%' then 1 end) as float)/count(*) * 100, 3) as ratio
from artworks
;
