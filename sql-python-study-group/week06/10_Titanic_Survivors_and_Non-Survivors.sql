select
    survived,
    count(case when pclass = 1 then 1 end) as first_class,
    count(case when pclass = 2 then 1 end) as second_class,
    count(case when pclass = 3 then 1 end) as third_class
from titanic
group by survived
;
