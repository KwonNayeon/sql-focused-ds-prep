select
    a.number as number_1,
    b.number as number_2,
    greatest(a.number, b.number) as max_number
from deloitte_numbers a
cross join deloitte_numbers b
;
