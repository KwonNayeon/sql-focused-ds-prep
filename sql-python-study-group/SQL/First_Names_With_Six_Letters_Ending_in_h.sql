-- 내 풀이
select *
from worker
where right(first_name, 1) = 'h'
and length(first_name) = 6
;

-- 다른 풀이
select *
from worker
where first_name like '_____h'
;
