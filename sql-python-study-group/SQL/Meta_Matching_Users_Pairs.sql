select
    a.id as employee_1,
    b.id as employee_2
from facebook_employees a
join facebook_employees b
on a.location = b.location
and a.age != b.age
and a.gender = b.gender
and a.is_senior != b.is_senior
;
