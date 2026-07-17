select
    first_name,
    department
from worker
where department='HR'

union all

select
    first_name,
    department
from worker
where department='HR'
;

-- union: 두 결과를 합친 후 중복 제거
-- union all: 단순히 두 결과를 합침, 중복을 제거하지 않음
