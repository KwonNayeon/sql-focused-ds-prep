select
    min(age) as lowest_age,
    avg(age) as mean_age,
    max(age) as highest_age
from olympics_athletes_events
;
