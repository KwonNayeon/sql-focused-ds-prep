select
    distinct variety
from winemag_p2
where taster_name = 'Roger Voss'
and region_1 is not null
;
