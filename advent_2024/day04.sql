select local, count(*) as num_stations
from station
group by local
order by count(*) asc;
