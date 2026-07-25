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

-- Review Notes:
-- 2026-07-25: 복습, 비율 계산 시 나눗셈 전에 한쪽을 실수형으로 만들어 주는 것 잊지 말기
