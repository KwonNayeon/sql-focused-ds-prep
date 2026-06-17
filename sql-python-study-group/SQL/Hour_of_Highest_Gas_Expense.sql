with rank as (
    select
        hour,
        gasoline_cost,
        row_number() over (order by gasoline_cost desc) as rn
    from lyft_rides
)
select
    hour
from rank
where rn = 1
;
