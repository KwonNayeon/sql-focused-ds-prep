select
    name
from olympics_athletes_events
where age > 39
and medal in ('Bronze', 'Silver')
;
